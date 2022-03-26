//
//  HomeView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 22/03/22.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText: String = ""
    @State var showMenu : Bool = false
    @State var offset : CGFloat = 0
    @State var lastOffset : CGFloat = 0

    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100{
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
       // let sideBarWidth : CGFloat = UIScene.main.bounds.width - 100
       return GeometryReader { geometry in
            ZStack(alignment: .leading){
        ScrollView{
        
            HStack(alignment: .center, spacing: 20.0){
                Button(action:{
                    withAnimation {
                        self.showMenu.toggle()

                    }
                }){
                    
                    Image("menuic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25.0, height: 25.0)

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
                    
                    Image("filter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25.0, height: 25.0)

                }
                    
            }
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
                .frame(minWidth: geometry.size.width * 1,maxHeight: 70)
                .background(Color(uiColor: UIColor.red))
            
        }
                if showMenu{
                    SideMenu()
                        .frame(width: geometry.size.width/1.3)
                        .transition(.move(edge: .leading))
                }
             
        } .gesture(drag)
            .background(Color.black)

               
    }.navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
