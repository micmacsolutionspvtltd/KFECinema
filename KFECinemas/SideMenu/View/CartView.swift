//
//  CartView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct CartView: View {
    @State var deliveryCLicked : Bool = true
    @State var collectionClicked : Bool = false
    var body: some View {
       // @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
      
        GeometryReader { geometry in
             
            ZStack{
                ScrollView {
                VStack{
                    ZStack{
                        Text("Cart")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                            HStack(alignment: .bottom ){
                                Button(action:{
                                //    presentationMode.wrappedValue.dismiss()
                                }){
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
                   // if #available(iOS 14.0, *) {
                        List{
                            ForEach(0..<1){_ in
                                CartAddItemCell()
                                    .background(Color("ColorAppGrey"))
                                    .frame(height: 70)
                                    .cornerRadius(5)
                                    .background(Color.black)

                            }
                        }.listStyle(.plain)
                       // .frame( height: geometry.size.height)
                       // .background(Color.black)
                    Divider()
                        .frame(height: 2)
                        .background(Color.white.opacity(0.7))
                    HStack{
                        Button{
                            deliveryCLicked = true
                            collectionClicked = false
                        }  label:{
                            HStack{
                            
                                Image(systemName: deliveryCLicked ? "circle.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                Text("Deliver")
                                    .foregroundColor(.white)
                                
                            }.frame(width: 150,alignment: .leading)
                                .padding([.leading],5)
                        }
                        Button{
                            deliveryCLicked = false
                            collectionClicked = true
                        }  label:{
                            HStack{
                                Image(systemName: collectionClicked ? "circle.circle.fill" : "circle")
                                    .resizable()
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                                Text("TakeAway")
                                    .foregroundColor(.white)
                                
                            }.frame(width: 150)
                        }
                        Spacer()
                    }.frame(width: geometry.size.width, height: 60)
                    VStack(alignment :.leading , spacing: 5){
                        Text("Offers")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                        Button{
                            
                        }label: {
                            HStack{
                                Text("Select Promo Code")
                                    .foregroundColor(.white)
                                Spacer()
                                Text("View Offers")
                                    .foregroundColor(.red)
                                    .fontWeight(.semibold)
                            }
                        }
                        Divider()
                            .frame(height: 2)
                            .background(Color.white.opacity(0.7))
                            .padding([.bottom],20)
                    }
                    if deliveryCLicked{
                        VStack{
                            CartItemContentView(tittleText: "Date Of Order", buttonName: "30/03/2022", imageName: "calendar")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Theatre Name", buttonName: "M1 Cinemas", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Screen Name", buttonName: "Screen 1", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Show", buttonName: "6.00am", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Seat Area", buttonName: "Elite", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Seat Area", buttonName: "Elite", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                        }
                        VStack(spacing : 5){
                            HStack{
                              Text("Item Total")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("20000")
                                      .fontWeight(.semibold)
                                      .foregroundColor(.white)
                            }
                            HStack{
                              Text("Delivery Charge")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("20000")
                                      .fontWeight(.semibold)
                                      .foregroundColor(.white)
                            }
                            HStack{
                              Text("Grand Total")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("200")
                                      .fontWeight(.semibold)
                                      .foregroundColor(.white)
                            }
                        }.frame(width: geometry.size.width)
                            .padding([.bottom],100)
                    }else{
                        VStack{
                            
                            CartItemContentView(tittleText: "Date Of Order", buttonName: "30/03/2022", imageName: "calendar")
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Takeaway Time", buttonName: "15 mins", imageName: "chevron.down")
                                .frame(width: geometry.size.width, height: 70)
                        }
                        VStack(spacing : 5){
                            HStack{
                              Text("Item Total")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("20000")
                                      .fontWeight(.semibold)
                                      .foregroundColor(.white)
                            }
                        
                            HStack{
                              Text("Grand Total")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("200")
                                      .fontWeight(.semibold)
                                      .foregroundColor(.white)
                            }
                        }.frame(width: geometry.size.width)
                            .padding([.bottom],100)
                    }
         
                }
              
            }
                Button{
                    
                } label: {
                    HStack{
                            //.fontWeight(.bold)
                    Text("PROCEED TO PAYMENT")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 5))
                        
                    // Spacer()
                        Text("$ 300")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                        
                    }
                    .frame(width: geometry.size.width*0.8, height: 25, alignment: .center)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(.infinity)
                }.position(x: geometry.size.width/2, y: geometry.size.height/1.07)
            }
        //}
        }
    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .background(Color.black)
    }
}
