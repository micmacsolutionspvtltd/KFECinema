//
//  Dashboard.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 28/03/22.
//

import SwiftUI

struct Dashboard: View {
    @State private var isActive : Bool = false

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
    @State var showLoader : Bool = true
    @State var showToast : Bool? = false
    @State var showTheaterSelectPopup : Bool? = false
    @State var passwordPopup : Bool? = false
        // @State var moActive : Bool = false
    @State var toastMsgs : String = "Incorrect password"
    @State var nonActive : Bool = false
    @EnvironmentObject var dashboardServices:DashboardServices
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
  //  let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State var nextPage = 0
  //  var proxy: ScrollViewProxy? = nil
    var body: some View {
        NavigationView{
            ZStack {
                ScrollView(showsIndicators: false){
                    AppBarView(openMenu: self.openMenu)
                    ScrollViewReader { (proxy: ScrollViewProxy) in
                        ScrollView(.horizontal,showsIndicators: false) {
                            HStack {
                                ForEach(dashboardServices.bannerImages, id: \.id) { banner in
                                    let bannerModel:BannerModel = banner
                                    let url = Endpoint.bannerImages.url + bannerModel.imageURL
                                    BannerImageView(withURL: url)
                                }
                            }
//                            .onReceive(timer, perform: { _ in
//                                if dashboardServices.bannerImages.count != 0{
//                                nextPage += 1
//                                if dashboardServices.bannerImages.count == nextPage{
//                                    nextPage = 0
//                                }
//
//                            }
//                            })
                            .onAppear {
//                                dashboardServices.getAllBannerImages(completionHandler: ({ result in
//
//                                }))
                              //  scrollView.scrollTo(notes[notes.endIndex - 1])
                            }
//                            .onChange(of: nextPage, perform: { value in
//                                withAnimation {
//                                    proxy.scrollTo((value), anchor: .center)
//                                }
//                            })
                            
                        }
                      
                        
                        
                    }
                    TableHeaderView(title: "Movies in Cinemas", imageName: "clapperboardWhite", isActive: $isActive,isViewAllVisible: true, popShowed: $showTheaterSelectPopup) {
                        MovieView()
                    }
                    HStack {
                        Text("NEW RELEASES : Spice Cinemas").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
                        Spacer()
                    }.padding(.leading,5)
                    ScrollView(.horizontal,showsIndicators:false) {
                        HStack (spacing:30){
                            ForEach(dashboardServices.spiceCinemas, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie:movie ) ) {
                                    MovieCardView(model: movie).frame(width: 150, height: 250)
                                }.isDetailLink(false)
                                
                            }
                        }
                    }.padding(.leading,5)
                    HStack {
                        Text("NEW RELEASES : M1 Cinemas").foregroundColor(.white).opacity(0.7).font(.system(size: 16, weight:.bold))
                        Spacer()
                    }.padding(.leading,5)
                    ScrollView(.horizontal,showsIndicators:false) {
                        HStack (spacing:30){
                            ForEach(dashboardServices.moneCinemas, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie:movie)) {
                                    MovieCardView(model: movie).frame(width: 150, height: 250)
                                }
                                
                            }
                        }
                    }.padding(.leading,5)
                    
                    TableHeaderView(title: "Spice Kitchen", imageName: "tray", isActive: $nonActive,isViewAllVisible: true, popShowed: $showTheaterSelectPopup){
                        SpiceKitchenView(pageName : "Spice Kitchen" )
                    }
                    ScrollView(.horizontal,showsIndicators:false) {
                        HStack (spacing:20){
                            ForEach(dashboardServices.spiceKitchenItems, id: \.id) { movie in
                                NavigationLink(destination: SpiceKitchenView(pageName : "Spice Kitchen")) {
                                    SpiceKitchenCardView(model: movie).frame(width: 150, height: 220).cornerRadius(10)
                                }//.isDetailLink(false)
                            }
                        }
                    }.padding(.leading,5)
                    VStack {
                        TableHeaderView(title: "Concession Zone", imageName: "fastfood1", isActive: $nonActive,isViewAllVisible: true, popShowed: $showTheaterSelectPopup){
                            FoodSelectTheatrePopup()
                           // SpiceKitchenView(pageName : "Concession Zone")
                        }
                        ScrollView(.horizontal,showsIndicators:false) {
                            HStack (spacing:20){
                                ForEach(dashboardServices.concessionZoneItems, id: \.id) { movie in
                                  //  NavigationLink(destination: SpiceKitchenView(pageName : "Concession Zone")) {
                                    Button{
                                        showTheaterSelectPopup = true
                                    }label: {
                                        ConcessionZoneCardView(model: movie).frame(width: 150, height: 220).cornerRadius(10)
                                    }
                                }
                            }
                        }.padding(.leading,5)
                        TableHeaderView(title: "Theatres", imageName: "clapperboardWhite", isActive: $nonActive ,isViewAllVisible: false, popShowed: $showTheaterSelectPopup){
                            SpiceKitchenView()
                        }
                        ScrollView(.horizontal,showsIndicators:false) {
                            HStack (spacing:20){
                                ForEach(dashboardServices.activeTheatres, id: \.id) { theatre in
                                  
                                    NavigationLink(destination: MoviesListView(viewTheatre : theatre.cinemaStrName ?? "")) {
                                            if theatre.cinemaStrName != "Leela Mahal"{
                                        TheatreCardView(model: theatre).frame(width: 220, height: 300).cornerRadius(10)
                                    }
                                    }
                                   
                                }
                            }
                        }.padding(.leading,5)
                    }
                }.background(Color("ColorAppGrey"))
                SideMenu(width:UIScreen.main.bounds.size.width - 50,
                                    isOpen: self.menuOpen,
                         menuClose: self.openMenu, popupShow: $showTheaterSelectPopup, changePassword: $passwordPopup)
                if showTheaterSelectPopup ?? false{
                    GeometryReader{_ in
                    FoodTheaterSelectPopupView()
                        .frame(width: 340, height: 220)
                        .background(Color.white)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                    }
                    .background(Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                               showTheaterSelectPopup = false
                            }
                        })
                }
                if passwordPopup ?? false{
                    GeometryReader{_ in
                        ChangePasswordView(showToast: $showToast, hidePopUp: $passwordPopup, toastMsg: $toastMsgs)
                        .frame(width: 340, height: 340)
                        .background(Color.white)
                        .background(Color.white)
                        .cornerRadius(8)
                    
                        .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
                    }
                    .background(Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                               showTheaterSelectPopup = false
                            }
                        })
                }
            }
        }.onAppear {
            showTheaterSelectPopup = false
            storeDataViewModel.deleteAllDatas()
          //  dashboardServices.getAllBannerImages()
            dashboardServices.getAllBannerImages(completionHandler: ({ result in
                
            }))
            dashboardServices.getAllFilms()
            dashboardServices.getAllSpiceKitchenItems()
            dashboardServices.getConcessionZoneItems()
            dashboardServices.getAllActiveTheatres()
            dashboardServices.getParticularCinemaApi(cinemaCode: "0002")
            dashboardServices.getParticularCinemaApi(cinemaCode: "0003")
            dashboardServices.getUpcomingMovies()
            showLoader = false
            // scrollView.scrollTo(movieNotes[movieNotes.endIndex - 1])
        }.navigationBarHidden(true).navigationTitle("").navigationBarTitle("").navigationViewStyle(.stack)
            .environment(\.rootPresentationMode, self.$isActive)
           // .createLoader(isShowing: $showLoader)]
            .loaderView(isShowing: $showLoader)
            .toast(isShowing: $showToast, textContent : toastMsgs)
    }
    
    func openMenu() {
            self.menuOpen.toggle()
        }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard( toastMsgs: "")
    }
}

struct AppBarView: View {
    @State private var searchText: String = ""
    @EnvironmentObject var dashboardServices:DashboardServices
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
                TextField("Search movie", text: $searchText).onChange(of: searchText, perform: { newValue in
                    print(newValue)
                    dashboardServices.searhFilter(text: newValue)
                })
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
    let imageName : String
    @Binding var isActive : Bool
   @State var isViewAllVisible:Bool = false
    @Binding var popShowed : Bool?
    @ViewBuilder var content: Content
    var body: some View {
        HStack{
            Image(imageName).resizable().frame(width: 18, height: 18)
            Text(title).font(.system(size: 16)).fontWeight(.bold).foregroundColor(.white)
            Spacer()
            if !isViewAllVisible {
                EmptyView()
            }else{
                if title == "Concession Zone"{
                    Button{
                        popShowed = true
                    }label: {
                        HStack(spacing : 15){
                            Text("View All").font(.system(size: 13)).fontWeight(.bold).foregroundColor(.white)
                            Image(systemName: "arrow.right").foregroundColor(.white)
                        }
                        .padding(8).frame(width: 110,height: 30).background(.red).cornerRadius(15)
                    }
                }else{
                NavigationLink(isActive : $isActive){
                    content
                }label: {
                    HStack(spacing : 15){
                        Text("View All").font(.system(size: 13)).fontWeight(.bold).foregroundColor(.white)
                        Image(systemName: "arrow.right").foregroundColor(.white)
                    }
                    .padding(8).frame(width: 110,height: 30).background(.red).cornerRadius(15)
                }.isDetailLink(false)
                }
                
            }
            
        }.padding(EdgeInsets(top: 15, leading: 8, bottom: 15, trailing: 5)).background(.black)
            .onAppear(){
               // isViewAllVisible = true
            }
    }
}
