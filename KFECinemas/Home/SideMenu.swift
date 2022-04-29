//
//  SideMenu.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 26/03/22.
//

import SwiftUI

struct SideMenu: View {
 //   @Binding var showMenu : Bool
    @State var navigationType:SideMenuType?
    let width: CGFloat
        var isOpen: Bool
        let menuClose: () -> Void
    var body: some View {
        ZStack {
            GeometryReader { _ in
                            EmptyView()
                        }
                        .background(Color.gray.opacity(0.3))
                        .opacity(self.isOpen ? 1.0 : 0.0)
                        .animation(Animation.easeIn.delay(0.25))
                        .onTapGesture {
                            self.menuClose()
                        }
            VStack(alignment: .leading, spacing: 20){
                VStack(alignment: .leading, spacing: 15){
                    Image("pro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height:65 )
                        .clipShape(Circle())
                        .padding(.leading, 35.0)
                    Text("Naveen Kumar")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("8248350384")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
                    .padding(.leading)
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment: .leading, spacing: 30){
                        TabButton(type: SideMenuType.home)
                        TabButton(type: SideMenuType.movies)
                        TabButton(type: SideMenuType.bookHistory)
                        TabButton(type: SideMenuType.spiceKitchen)
                        TabButton(type: SideMenuType.concessionZone)
                        TabButton(type: SideMenuType.changePassword)
                        TabButton(type: SideMenuType.logout)
                    }.padding()
                }
                    
            }.frame(width: self.width)
                .background(LinearGradient(gradient: SwiftUI.Gradient(colors: [Constants.CustomColors.sideMenuColor1,Constants.CustomColors.sideMenuColor2]), startPoint: .top, endPoint: .bottom))
                .offset(x: self.isOpen ? -30 : -(self.width + 50))
                .animation(.default)
        }
                         
    }
    
    
    @ViewBuilder
    func TabButton(type:SideMenuType) -> some View{
        NavigationLink{

            switch type {
            case .home:
                 Dashboard()
            case .movies:
                MovieView()
            case .bookHistory:
                 Dashboard()
            case .spiceKitchen:
                SpiceKitchenView(pageName : "Spice Kitchen")
            case .concessionZone:
                SpiceKitchenView(pageName : "Concession Zone")
            case .changePassword:
                 Dashboard()
            case .logout:
                 LoginView()
            }
        }label: {
            HStack(spacing : 15){
                Image(type.getImageName())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                Text(type.getTitle())
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(width: 300, isOpen: true, menuClose: {
            
        })
    }
}


enum SideMenuType {
    case home
    case movies
    case bookHistory
    case spiceKitchen
    case concessionZone
    case changePassword
    case logout
    
    
    func getTitle()->String {
        switch self {
        case .home:
            return "Home"
        case .movies:
            return "Movies"
        case .bookHistory:
            return "Book History"
        case .spiceKitchen:
            return "Spice Kitchen"
        case .concessionZone:
            return "Concession Zone"
        case .changePassword:
            return "Change Password"
        case .logout:
            return "Log out"
        }
    }
    
    func getImageName()->String {
        switch self {
        case .home:
            return "clapperboard"
        case .movies:
            return "clapperboard"
        case .bookHistory:
            return "clapperboard"
        case .spiceKitchen:
            return "tray"
        case .concessionZone:
            return "fastfood1"
        case .changePassword:
            return "clapperboard"
        case .logout:
            return "clapperboard"
        }
    }
}
