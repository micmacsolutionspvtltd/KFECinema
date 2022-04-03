//
//  MovieView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct MovieView: View {
    
    @State private var searchText: String = ""
    @State var menuOpen: Bool = false
    let movies = [
           MovieModel(name: "Kaapan"),
           MovieModel(name: "Soorari potru"),
           MovieModel(name: "Naruto"),
           MovieModel(name: "Minato"),
       ]
    
    let movieNotes = [
        MoviesModel(imageName: "food1"),
        MoviesModel(imageName: "food2"),
        MoviesModel(imageName: "food3"),
        MoviesModel(imageName: "food4")
    
    ]
    var body: some View {
        
       return  ScrollView{
           HStack {
               TextField("Movies", text: $searchText)
                   .foregroundColor(.white)
                   .accentColor(Color.white)
               
               
            
               Button(action:{
                   
               }){
                   
                   Image(systemName:  "magnifyingglass")
               }
               
           }
           .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
           .overlay(
               RoundedRectangle(cornerRadius: .infinity)
                   .stroke(Color.black, lineWidth: 0.5)
           ).padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
           //                .frame(minWidth: geometry.size.width * 1,maxHeight: 70)
           .background(Color(uiColor: UIColor.red))
           TableHeaderView(title: "Movies on Theatre")
           HStack {
               Text("NEW RELEASES").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
               Spacer()
           }.padding(.leading,5)
           ScrollView(.horizontal) {
               HStack (spacing:30){
                       ForEach(movies, id: \.id) { movie in
                           MovieCardView(model: movie).frame(width: 150, height: 250)
                           }
               }
           }.padding(.leading,5)
           TableHeaderView(title: "Theatres")
           HStack {
               Text("Upcoming Movies").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
               Spacer()
           }.padding(.leading,5).background(.black)
           ScrollView(.horizontal) {
               HStack (spacing:30){
                       ForEach(movies, id: \.id) { movie in
                           MovieCardView(model: movie).frame(width: 150, height: 250)
                           }
               }
           }.padding(.leading,5)
          
          
//            ScrollView(.horizontal) {
//                HStack (spacing:20){
//                        ForEach(movies, id: \.id) { movie in
//                            MovieCardView(model: movie).frame(width: 200, height: 400)
//                            }
//                }
//            }.padding(.leading,5)
       
//            List(movies) { movie in
//                        MovieCardView(model: movie)
//            }
          
       }.background(Color("ColorAppGrey"))
}
    
}
struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
