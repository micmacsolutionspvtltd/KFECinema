//
//  MovieDetailView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import SwiftUI

struct MovieDetailView: View {
    var body: some View {
        ScrollView{
            VStack {
                HStack(alignment: .top) {
                    Button(action:{
                        
                    }){
                        
                        Image(systemName:  "arrow.left").foregroundColor(.white).padding()
                    }
                    Spacer()
                    Image("food1").renderingMode(.original).resizable().frame(width: 180, height: 260).aspectRatio(contentMode: .fill)
                    Spacer()
                    
                }
                .padding()
            }
            VStack(spacing:5){
                HStack() {
                    Text("BAD BOYS FOR LIFE").foregroundColor(.white)
                    Divider().background(.white).frame(height:30)
                    Text("Telugu").foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("ACTION-CRIME-DRAMA").fontWeight(.semibold).foregroundColor(.blue)
                    Spacer()
                }
                
                HStack {
                    Image(systemName:  "clock.fill").foregroundColor(.white)
                    Text("123 mins").foregroundColor(.white).font(.system(size: 15))
                    Spacer()
                }
            }.padding(.leading,20)
           
            Divider().background(.white).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            VStack(alignment:.leading,spacing: 10) {
                Text("Storyline").padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)).foregroundColor(.white).font(.system(size: 14)).background(Color(hue: 1.0, saturation: 0.081, brightness: 0.866)).cornerRadius(5)
                Text("Old-school cops Mike Lowery and Marcus Burnett team up again to take down the vicious leader of a Miami drug carterl.An agin Burnett becomes a police inspector while Mike going through his mid-life crisis get asssigned as the head as AMMO")
                    .foregroundColor(Color.white).font(.system(size: 14))
                Text("CAST OVERVIEW").fontWeight(.bold).foregroundColor(.white).font(.system(size: 16))
                Text("Martin Lawrence, Vanessa Hudgens, Will Smith")
                    .foregroundColor(Color.white).font(.system(size: 14))
                Text("Director").fontWeight(.bold).foregroundColor(.white).font(.system(size: 15))
                Text("White walker")
                    .foregroundColor(Color.white).font(.system(size: 14))
            }.padding(.leading,20).padding(.bottom,20)
            Spacer()
            Button(action:{
                
            }){
                
                Text("BOOK TICKET")
            }.padding().frame(maxWidth: .infinity).background(.red)
           
        }.background(Color("ColorAppGrey")).ignoresSafeArea().navigationBarHidden(true)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
