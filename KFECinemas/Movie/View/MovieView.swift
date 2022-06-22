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
    @State var showTheaterSelectPopup : Bool? = false
    @State var isActive : Bool = false
    @EnvironmentObject var dashboardServices:DashboardServices
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 
    var body: some View {
        
       return  ScrollView(showsIndicators:false){
           HStack {
               Button(action:{
                   presentationMode.wrappedValue.dismiss()
               }){
                   
                   Image(systemName:  "arrow.left").foregroundColor(.white).padding()
               }
               Spacer()
               HStack {
                  
                   TextField("Movies", text: $searchText).onChange(of: searchText, perform: { newValue in
                       print(newValue)
                       dashboardServices.searhFilter(text: newValue)
                   })
                       .foregroundColor(.white)
                       .accentColor(Color.white)
                   
                   
                
                   Button(action:{
                       
                   }){
                       
                       Image(systemName:  "magnifyingglass").foregroundColor(.white)
                   }
                   
               }
               .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
               .overlay(
                   RoundedRectangle(cornerRadius: .infinity)
                       .stroke(Color.black, lineWidth: 0.5)
               ).padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
               Spacer()
                   
           }.background(Color(uiColor: UIColor.red))
           TableHeaderView(title: "Movies on Theatre", imageName: "clapperboardWhite", isActive: $isActive ,isViewAllVisible: false, popShowed: $showTheaterSelectPopup){
               MoviesListView()
           }
           HStack {
               Text("NEW RELEASES : Spice Cinemas").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
               Spacer()
           }.padding(.leading,5)
           ScrollView(.horizontal,showsIndicators:false) {
               HStack (spacing:30){
                       ForEach(dashboardServices.spiceCinemas, id: \.id) { movie in
                           NavigationLink(destination: MovieDetailView(movie:movie)) {
                           MovieCardView(model: movie).frame(width: 150, height: 250)
                           }.isDetailLink(false)
                           }
               }
           }.padding(.leading,5)
           HStack {
               Text("NEW RELEASES : M1 cinemas").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
               Spacer()
           }.padding(.leading,5)
           ScrollView(.horizontal,showsIndicators:false) {
               HStack (spacing:30){
                       ForEach(dashboardServices.moneCinemas, id: \.id) { movie in
                           NavigationLink(destination: MovieDetailView(movie:movie)) {
                           MovieCardView(model: movie).frame(width: 150, height: 250)
                           }.isDetailLink(false)
                           }
               }
           }.padding(.leading,5)

           TableHeaderView(title: "Theatres", imageName: "clapperboardWhite", isActive: $isActive,isViewAllVisible: false, popShowed: $showTheaterSelectPopup){
               Text("")
           }
           HStack {
               Text("Upcoming Movies").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
               Spacer()
           }.padding(.leading,5).background(.black)
           ScrollView(.horizontal,showsIndicators:false) {
               HStack (spacing:30){
                       ForEach(dashboardServices.upcomingMovies, id: \.id) { movie in
                           
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
          
       }.background(Color("ColorAppGrey")).navigationBarHidden(true).navigationViewStyle(.stack)
}
    
}
struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
