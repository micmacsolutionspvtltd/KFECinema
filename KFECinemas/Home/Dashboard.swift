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
    @EnvironmentObject var dashboardServices:DashboardServices
   
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
                ScrollView(showsIndicators: false){
                    AppBarView(openMenu: self.openMenu)
                    ScrollViewReader { scrollView in
                                ScrollView(.horizontal,showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(dashboardServices.bannerImages, id: \.id) { banner in
                                            let bannerModel:BannerModel = banner
                                            let url = Endpoint.bannerImages.url + bannerModel.imageURL
                                            BannerImageView(withURL: url)

                                        }
                                    }
                                    .onAppear {
                                        dashboardServices.getAllBannerImages()
                                       // scrollView.scrollTo(movieNotes[movieNotes.endIndex - 1])
                                    }
                                }
                            }
                    TableHeaderView(title: "Movies in Cinemas",isViewAllVisible: true) {
                        MovieView()
                    }
                    HStack {
                        Text("NEW RELEASES").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
                        Spacer()
                    }.padding(.leading,5)
                    ScrollView(.horizontal,showsIndicators:false) {
                        HStack (spacing:30){
                                ForEach(dashboardServices.allFilms, id: \.id) { movie in
                                    NavigationLink(destination: MovieDetailView(movie:movie)) {
                                        MovieCardView(model: movie).frame(width: 150, height: 250)
                                            }
                                   
                                    }
                        }
                    }.padding(.leading,5)
                    TableHeaderView(title: "Spice Kitchen",isViewAllVisible: true){
                        SpiceKitchenView()
                    }
                    ScrollView(.horizontal,showsIndicators:false) {
                        HStack (spacing:20){
                            ForEach(dashboardServices.spiceKitchenItems, id: \.id) { movie in
                                SpiceKitchenCardView(model: movie).frame(width: 150, height: 220).cornerRadius(10)
                                    }
                        }
                    }.padding(.leading,5)
                    
                    VStack {
                        TableHeaderView(title: "Concession Zone",isViewAllVisible: true){
                            SpiceKitchenView()
                        }
                        ScrollView(.horizontal,showsIndicators:false) {
                            HStack (spacing:20){
                                ForEach(dashboardServices.concessionZoneItems, id: \.id) { movie in
                                    ConcessionZoneCardView(model: movie).frame(width: 150, height: 220).cornerRadius(10)
                                        }
                            }
                        }.padding(.leading,5)
                        TableHeaderView(title: "Theatres",isViewAllVisible: true){
                            SpiceKitchenView()
                        }
                        ScrollView(.horizontal,showsIndicators:false) {
                            HStack (spacing:20){
                                ForEach(dashboardServices.activeTheatres, id: \.id) { theatre in
                                    TheatreCardView(model: theatre).frame(width: 220, height: 300).cornerRadius(10)
                                        }
                            }
                        }.padding(.leading,5)
                    }
                }.background(Color("ColorAppGrey"))
                SideMenu(width:UIScreen.main.bounds.size.width - 50,
                                    isOpen: self.menuOpen,
                                    menuClose: self.openMenu)
            }.onAppear {
                dashboardServices.getAllBannerImages()
                dashboardServices.getAllFilms()
                dashboardServices.getAllSpiceKitchenItems()
                dashboardServices.getConcessionZoneItems()
                dashboardServices.getAllActiveTheatres()
               // scrollView.scrollTo(movieNotes[movieNotes.endIndex - 1])
            }.navigationBarHidden(true).navigationTitle("").navigationBarTitle("")
            
       
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

struct TableHeaderView<Content: View>: View {
    let title:String
   @State var isViewAllVisible:Bool = false
    @ViewBuilder var content: Content
    var body: some View {
        HStack{
            Image("clapperboard").resizable().frame(width: 18, height: 18)
            Text(title).font(.system(size: 16)).fontWeight(.bold).foregroundColor(.white)
            Spacer()
            if !isViewAllVisible {
               EmptyView()
            }else{
                NavigationLink{
                    content
                }label: {
                    HStack(spacing : 15){
                        Text("View All").font(.system(size: 13)).fontWeight(.bold).foregroundColor(.white)
                        Image(systemName: "arrow.right").foregroundColor(.white)
                    }
                    .padding(8).frame(width: 110,height: 30).background(.red).cornerRadius(15)
                }
                
            }
            
        }.padding(EdgeInsets(top: 15, leading: 8, bottom: 15, trailing: 5)).background(.black)
    }
}
