//
//  SpiceKitchenView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct SpiceKitchenView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    var body: some View {
        GeometryReader { geometry in
          //  ScrollView {
            ZStack{

                VStack{
                    ZStack{
                        Text("Spice Kitchen")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                                                HStack(alignment: .bottom ){
                                                    NavigationLink{
                                                        Dashboard()
                                                      //  presentationMode.wrappedValue.dismiss()
                                                    }label: {
                                                        
                                                   
                                                        Image(systemName: "arrow.left")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 25.0, height: 25.0)
                                                            .foregroundColor(.white)
                            
                                                    }
                                                    Spacer()
                        }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 20, trailing: 20))
                    .frame(minWidth: geometry.size.width,maxHeight: 60)
                        .background(Color.red)
                 //   HStack{
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                            ForEach(0..<5){_ in
                                Image("food4")
                                    .resizable()
                                    .frame(minWidth: geometry.size.width*0.95,minHeight: 200, maxHeight: 200)
                            }
                           
                        }
                    }
                    .frame(width: geometry.size.width, height: 200)
                    HStack{
                        Spacer()
                        Button {
                            
                        } label: {
                            HStack{
                                Text("Veg")
                                    .foregroundColor(.white)
                                
                                Image(systemName: "circle.circle.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                            }.frame(width: 90)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: .infinity)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                            

                                
                        }

                    }
                    if #available(iOS 14.0, *) {
                        List{
                            Section(header : Text("Bakery Products")) {
                                ForEach(0..<5){_ in
                                    DishViewCell()
                                        .frame(width: geometry.size.width*0.65,height: 100)
                                        .padding()
                                        .padding([.leading,.trailing],25)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                }
                            }//.background(Color.black)
                        }.listStyle(.sidebar)
                       
                            .background(Color.black)
                    } else {
                        // Fallback on earlier versions
                    }

                    

                }
                NavigationLink{
                    CartPageView()
                } label: {
                    HStack(spacing :20){
                      Text("1 Itemss")
                            //.fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 100)
                        Text("$ 100")
                              .fontWeight(.bold)
                              .foregroundColor(.white)
                              .frame(height: 100)
                     Spacer()
                        Text("ADD")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                        .frame(width: 60, height: 10)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(.infinity)
                        
                    }
                    .frame(width: geometry.size.width*0.8, height: 35, alignment: .center)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(8)
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/1.1)
            }
            
            .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .background(Color.black)

        }
    }
}

struct SpiceKitchenView_Previews: PreviewProvider {
    static var previews: some View {
        SpiceKitchenView()
    }
}
