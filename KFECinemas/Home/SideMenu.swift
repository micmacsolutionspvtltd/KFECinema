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
    @Binding var popupShow : Bool?
    @Binding var changePassword : Bool?
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
                    Text(StorageSettings().userName)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(StorageSettings().mobileNumber)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }.padding(.horizontal)
                    .padding(.leading)
                ScrollView(.vertical,showsIndicators: false){
                    VStack(alignment: .leading, spacing: 30){
                      //  TabButton(type: SideMenuType.home)
                        Button{
                           // popupShow = true
                            self.menuClose()
                        }label: {
                            HStack(spacing : 15){
                                Image("houseIcon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill).colorMultiply(.black)
                                    .frame(width: 20, height: 20)
                                Text("Home")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TabButton(type: SideMenuType.movies)
                        TabButton(type: SideMenuType.bookHistory)
                        TabButton(type: SideMenuType.spiceKitchen)
                        Button{
                            popupShow = true
                            self.menuClose()
                        }label: {
                            HStack(spacing : 15){
                                Image("fastfood1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill).colorMultiply(.black)
                                    .frame(width: 20, height: 20)
                                Text("Concession Zone")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        TabButton(type: SideMenuType.myProfile)
                        Button{
                            changePassword = true
                            self.menuClose()
                        }label: {
                            HStack(spacing : 15){
                                Image("changePassword")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill).colorMultiply(.black)
                                    .frame(width: 20, height: 20)
                                Text("Change Password")
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                      //  TabButton(type: SideMenuType.concessionZone)
                      //  TabButton(type: SideMenuType.changePassword)
                        TabButton(type: SideMenuType.termsAndCondition)
                 
                        VStack(alignment: .leading, spacing: 30){
                            TabButton(type: SideMenuType.privacyAndPolicy)
                            TabButton(type: SideMenuType.ticketCancellation)
                            TabButton(type: SideMenuType.contactUs)
                            TabButton(type: SideMenuType.logout)
                        }
                      
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
            case .myProfile:
                MyProfilePageView()
            case .movies:
                MovieView()
            case .bookHistory:
                 OrderHistoryView()
            case .spiceKitchen:
                SpiceKitchenView(pageName : "Spice Kitchen")
            case .concessionZone:
                SpiceKitchenView(pageName : "Concession Zone",theaterName: "Spice Cinemas")
            case .changePassword:
                 Dashboard()
            case .termsAndCondition:
                TermsAndConditionWebView(urlName: APIList().getUrlString(url : .TERMSANDCONDITION) , pageName : "Terms and Condition")
            case .privacyAndPolicy:
                TermsAndConditionWebView(urlName: APIList().getUrlString(url : .PRIVACYPOLICY) , pageName: "Privacy and Policy")
            case .logout:
                 LoginView()
            case .ticketCancellation:
                TermsAndConditionWebView(urlName: APIList().getUrlString(url : .CANCELTICKET), pageName: "Cancellation Policy")
            case .contactUs:
                TermsAndConditionWebView(urlName: APIList().getUrlString(url : .CONTACTUS), pageName: "Contact Us")
            }
          
        }label: {
            HStack(spacing : 15){
                Image(type.getImageName())
                    .resizable()
                    .aspectRatio(contentMode: .fill).colorMultiply(.black)
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
            
        }, popupShow: .constant(false), changePassword: .constant(false))
    }
}


enum SideMenuType {
    case home
    case myProfile
    case movies
    case bookHistory
    case spiceKitchen
    case concessionZone
    case changePassword
    case termsAndCondition
    case privacyAndPolicy
    case ticketCancellation
    case contactUs
    case logout
   
    
    
    func getTitle()->String {
        switch self {
        case .home:
            return "Home"
        case .myProfile:
            return "My Profile"
        case .movies:
            return "Movies"
        case .bookHistory:
            return "Booking History"
        case .spiceKitchen:
            return "Spice Kitchen"
        case .concessionZone:
            return "Concession Zone"
        case .changePassword:
            return "Change Password"
        case .termsAndCondition:
            return "Terms and Condition"
        case .privacyAndPolicy:
            return "Privacy and Policy"
        case .logout:
            return "Log out"
        case .ticketCancellation:
            return "Cancellation Policy"
        case .contactUs:
            return "Contact Us"
        }
    }
    
    func getImageName()->String {
        switch self {
        case .home:
            return "houseIcon"
        case .myProfile:
            return "account"
        case .movies:
            return "clapperboard"
        case .bookHistory:
            return "historyBooking"
        case .spiceKitchen:
            return "tray"
        case .concessionZone:
            return "fastfood1"
        case .changePassword:
            return "changePassword"
        case .termsAndCondition:
            return "termsAndCondition"
        case .privacyAndPolicy:
            return "privacyPolicy"
        case .logout:
            return "logout"
        case .ticketCancellation:
            return "cancellation"
        case .contactUs:
            return "contactUs"
        }
    }
}
