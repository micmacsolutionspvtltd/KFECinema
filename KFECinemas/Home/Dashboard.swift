//
//  Dashboard.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 28/03/22.
//

import SwiftUI

struct Dashboard: View {
    
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
    
//    @State var showMenu : Bool = false
//    @State var offset : CGFloat = 0
//    @State var lastOffset : CGFloat = 0
    
//    var body: some View {
//        VStack {
//            Text("Naveen")
//        }
//    }
    var body: some View {
        ZStack {
            ScrollView{
                AppBarView(openMenu: self.openMenu)
                ScrollViewReader { scrollView in
                            ScrollView(.horizontal) {
                                LazyHStack {
                                    ForEach(movieNotes, id: \.id) { note in
                                        Image(note.imageName).resizable().frame(width:UIScreen.main.bounds.size.width,height: 200)
                                    }
                                }
                                .onAppear {
                                    scrollView.scrollTo(movieNotes[movieNotes.endIndex - 1])
                                }
                            }
                        }
                TableHeaderView(title: "Movies in Cinemas")
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
                TableHeaderView(title: "Spice Kitchen")
                ScrollView(.horizontal) {
                    HStack (spacing:20){
                            ForEach(movies, id: \.id) { movie in
                                FoodCardView(model: movie).frame(width: 140, height: 220)
                                }
                    }
                }.padding(.leading,5)
                TableHeaderView(title: "Concession Zone")
                ScrollView(.horizontal) {
                    HStack (spacing:20){
                        ForEach(movies, id: \.id) { movie in
                            FoodCardView(model: movie).frame(width: 140, height: 220)
                            }
                    }
                }.padding(.leading,5)
                TableHeaderView(title: "Theatres")
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
            SideMenu(width:UIScreen.main.bounds.size.width,
                                isOpen: self.menuOpen,
                                menuClose: self.openMenu)
        }
    }
    
    func openMenu() {
            self.menuOpen.toggle()
        }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}

struct AppBarView: View {
    @State private var searchText: String = ""
    var openMenu: () -> Void
    var body: some View {
        HStack(alignment: .center, spacing: 20.0){
            Button(action:{
                withAnimation {
                    openMenu()
                }
            }){
                
                Image("menuic")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
            }
            
            
            HStack {
                TextField("Enter your password", text: $searchText)
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
            )
            Button(action:{
                
            }){
                
                Image("filter").renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
            }
            
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
        //                .frame(minWidth: geometry.size.width * 1,maxHeight: 70)
        .background(Color(uiColor: UIColor.red))
    }
}

struct TableHeaderView: View {
    let title:String
    var body: some View {
        HStack{
            Image("clapperboard").resizable().frame(width: 18, height: 18)
            Text(title).font(.system(size: 16)).fontWeight(.bold).foregroundColor(.white)
            Spacer()
            Button(action: {
                
            }){
                Text("View All").font(.system(size: 13)).fontWeight(.bold).foregroundColor(.white)
                Image(systemName: "arrow.right").foregroundColor(.white)
            }.padding(8).frame(width: 110,height: 30).background(.red).cornerRadius(15)
        }.padding(EdgeInsets(top: 15, leading: 8, bottom: 15, trailing: 5)).background(.black)
    }
}
