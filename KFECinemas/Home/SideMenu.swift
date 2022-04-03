//
//  SideMenu.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 26/03/22.
//

import SwiftUI

struct SideMenu: View {
 //   @Binding var showMenu : Bool
    
    let width: CGFloat
        let isOpen: Bool
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
                    Image("facebook")
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
                        TabButton(tittle: "Home", image: "facebook")
                        TabButton(tittle: "Movies", image: "facebook")
                        TabButton(tittle: "Book History", image: "facebook")
                        TabButton(tittle: "Spice Kitchen", image: "facebook")
                        TabButton(tittle: "Concession Zone", image: "facebook")
                        TabButton(tittle: "Change Password", image: "facebook")
                        TabButton(tittle: "Log Out", image: "facebook")
                    }.padding()
                }
                    
            }.frame(width: self.width)
                .background(LinearGradient(gradient: SwiftUI.Gradient(colors: [.blue,.purple]), startPoint: .bottom, endPoint: .top))
                .offset(x: self.isOpen ? 0 : -self.width)
                .animation(.default)
        }
                         
    }
    
    
    @ViewBuilder
    func TabButton(tittle: String , image : String) -> some View{
        NavigationLink{
            SpiceKitchenView()
        }label: {
            HStack(spacing : 15){
              Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20, height: 20)
                Text(tittle)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

//struct SideMenu_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenu()
//    }
//}
