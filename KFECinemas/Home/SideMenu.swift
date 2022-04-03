//
//  SideMenu.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 26/03/22.
//

import SwiftUI

struct SideMenu: View {
 //   @Binding var showMenu : Bool
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 20){
            VStack(alignment: .leading, spacing: 15){
                Image("facebook")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height:65 )
                    .clipShape(Circle())
                    .padding(.leading, 35.0)
                Text("Naveen Kumar")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Text("8248350384")
                    .fontWeight(.bold)
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
                    Text("Hello").padding()
                }.padding()
            }
                
        }.background(LinearGradient(gradient: SwiftUI.Gradient(colors: [.blue,.purple]), startPoint: .bottom, endPoint: .top))
                         
                         
//                            .background(LinearGradient(colors: [.red,.blue], startPoint: .bottom, endPoint: .top))
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

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}
