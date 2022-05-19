//
//  CheckoutView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/05/22.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var movieServices:MovieServices
    var body: some View {
//        GeometryReader { geometry in
        ZStack(alignment:.bottom){
        ScrollView(showsIndicators:false){
            VStack {
                VStack {
                    HStack(alignment: .center) {
                        Button(action:{
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            
                            Image(systemName:  "arrow.left").foregroundColor(.white).padding()
                        }
                        Spacer()
                        Text("Checkout").font(.system(size: 22)).fontWeight(.bold)
                        Spacer()
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                  
                }.background(Color.red)
                
                VStack{
                    CustomDivider()
                    
                    HStack {
                        Spacer()
                        VStack(alignment:.leading){
                            CheckoutHeadingView(header: "Theatre Name", value: movieServices.checkoutDetails?.theatreName ?? "Spice cinemas").padding(.bottom,10)
                            CheckoutHeadingView(header: "Date", value: movieServices.checkoutDetails?.theatreName ?? "19-05-2022").padding(.bottom,10)
                            CheckoutHeadingView(header: "Seat Row", value: movieServices.checkoutDetails?.theatreName ?? "C H")
                        }
                        Spacer()
                        VStack(alignment:.leading){
                            CheckoutHeadingView(header: "Screen Name", value: movieServices.checkoutDetails?.theatreName ?? "SCREEN-5").padding(.bottom,10)
                            CheckoutHeadingView(header: "Show Time", value: movieServices.checkoutDetails?.theatreName ?? "12:25 PM").padding(.bottom,10)
                            CheckoutHeadingView(header: "Seat No", value: movieServices.checkoutDetails?.theatreName ?? "ELITE - D 4,D 5")
                        }
                        Spacer()
                    }
                    CustomDivider()
                    DeliveryButtonGroups { selected in
                                    print("Selected Gender is: \(selected)")
                    }.padding(.horizontal,15).padding(.vertical,10)
                    CustomDivider()
                    DeliveryTimeGroups { selected in
                                    print("Selected Gender is: \(selected)")
                    }.padding(.horizontal,15).padding(.vertical,10)
                    CustomDivider()
                }
                
                VStack(alignment:.leading){
                    Text("Offers").foregroundColor(.white).fontWeight(.bold).padding(.horizontal,10).padding(.vertical,5)
                    HStack{
                        Text("Select a Promo code").foregroundColor(.white)
                        Spacer()
                        NavigationLink{
                            MovieView()
                        } label: {
                            Text("View Offers").foregroundColor(.red)
                                
                        }
                    }.padding(.horizontal,10).padding(.vertical,5)
                    CustomDivider()
                }
               
                VStack{
                    CheckoutPriceView(header: "Ticket Price", value: "$ 400.0")
                    CheckoutPriceView(header: "Snacks and Beverage Price", value: "$ 200.0")
                    CheckoutPriceView(header: "Deliver Price", value: "$ 10.0")
                    CustomDivider()
                    CheckoutPriceView(header: "Total Price", value: "$ 710.0")
                    CustomDivider()
                }.padding(.bottom,80)
                
               
            }
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true).onAppear(perform: {
           
        }).background(Color("ColorAppGrey"))
            NavigationLink{
               MovieView()
            } label: {
                HStack(spacing :20){
                    Text("PROCEED PAYMENT")
                    .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 100)
                    Spacer()
                    Text("₹ \(movieServices.calculateTotalPrice())")
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                        .frame(height: 100)
                       
                  
                    
               }
                .frame(maxWidth: .infinity)
                .frame(height : 25)
            //    .frame(width: geometry.size.width*0.8, height: 35, alignment: .center)
             //   .padding(EdgeInsets(top: 10, left: -15, bottom: 10, right: -15))
                .padding(.vertical , 15)
                .padding(.horizontal,10)
                
                .background(Color.red)
                .cornerRadius(25)
            }.padding(.horizontal,10)
           }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}

struct CheckoutHeadingView: View {
    var header:String
    var value:String
    var body: some View {
        VStack(alignment:.leading) {
            Text(header)
            Spacer()
            Text(value)
        }
    }
    
}

struct CheckoutPriceView: View {
    var header:String
    var value:String
    var body: some View {
        HStack {
            Text(header)
            Spacer()
            Text(value)
        }.padding(.horizontal,15).padding(.vertical,5)
    }
    
}
