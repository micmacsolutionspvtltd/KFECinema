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
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    @EnvironmentObject var promoDataViewModel : PromoViewModel
    @State var applyCouponData : PromoAmtCalculateModel?
    @State var razorPayShow : Bool? = false
    @State var snacksOrderMode : String? = "1"
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
                            CheckoutHeadingView(header: "Date", value:  Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? "")).padding(.bottom,10)
                            CheckoutHeadingView(header: "Seat Row", value: ((movieServices.selectedSeats[0].ticketType ?? "") + (movieServices.checkoutDetails?.seatNo ?? "")))
                        }
                        Spacer()
                        VStack(alignment:.leading){
                            CheckoutHeadingView(header: "Screen Name", value: movieServices.checkoutDetails?.screenName ?? "SCREEN-5").padding(.bottom,10)
                            CheckoutHeadingView(header: "Show Time", value: movieServices.checkoutDetails?.showTime ?? "12:25 PM").padding(.bottom,10)
                            CheckoutHeadingView(header: "Seat No", value: movieServices.checkoutDetails?.theatreName ?? "ELITE - D 4,D 5")
                        }
                        Spacer()
                    }
                    CustomDivider()
                    if storeDataViewModel.items.count != 0{
                    DeliveryButtonGroups { selected in
                        if selected == "Deliver"{
                            snacksOrderMode = "1"
                        }else{
                            snacksOrderMode = "0"
                        }
                                    print("Selected Gender is: \(selected)")
                    }.padding(.horizontal,15).padding(.vertical,10)
                    CustomDivider()
                    DeliveryTimeGroups { selected in
                        
                                    print("Selected Gender is: \(selected)")
                    }.padding(.horizontal,15).padding(.vertical,10)
                    CustomDivider()
                    }
                }
                if storeDataViewModel.items.count != 0{
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
                }
                VStack{
                    CheckoutPriceView(header: "Ticket Price", value:"₹ \(movieServices.checkoutDetails?.totalPrice ?? "")")
                    if storeDataViewModel.items.count != 0{
                    CheckoutPriceView(header: "Snacks and Beverage Price", value:"₹ \(storeDataViewModel.calculateTotalPrice())")
                    CheckoutPriceView(header: "Deliver Price", value: "₹ 10.0")
                    }
                    CustomDivider()
                    CheckoutPriceView(header: "Total Price", value: String((Float(movieServices.checkoutDetails?.totalPrice ?? "0") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00)))
                    CustomDivider()
                }.padding(.bottom,80)
                
               
            }
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true).onAppear(perform: {
           
        }).background(Color("ColorAppGrey"))
            Button{
             //   razorPayShow = true
                var calculateTotalAmount : Float = 0.00
                if storeDataViewModel.items.count == 0{
                    calculateTotalAmount = (Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00)
                }else{
                    if snacksOrderMode == "1"{
                        calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00))
                    }else{
                        calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00))
                    }
                }
            
               
                let paymentData = getFinalPaymentProcessData()
                movieServices.ticketBookingApi(movieId: "1", movieName: movieServices.checkoutDetails?.movieName ?? "", bookingDate: Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? ""), showTime: movieServices.checkoutDetails?.showTime ?? "", theaterId: (movieServices.checkoutDetails?.theatreName ?? "") == "Spice  Cinemas" ? "7" : "8", screenId: "1", screenName: (movieServices.checkoutDetails?.screenName ?? "").removeWhitespace(), screenZone: movieServices.selectedSeats[0].ticketType ?? "", snackstatus: storeDataViewModel.items.count == 0 ? "0" : "1", numberOfTickets: String(movieServices.selectedSeats.count), seatNo: movieServices.calculateSeats().removeWhitespace(), movieAmt: String((Int(movieServices.checkoutDetails?.ticketPrice ?? "") ?? 0) * (storeDataViewModel.items.count)), snacksAmount: storeDataViewModel.calculateTotalPrice(), itemNames: paymentData.2, totalAmt: String(format: "%.2f", calculateTotalAmount) , snacksItemId: paymentData.0, snacksCatId: paymentData.1, snacksQuantityId: paymentData.4, snacksPrice: paymentData.3, promocode: "", discountPrice: "" , snacksDeliveryAmt: snacksOrderMode == "0" ? "" : "10", snacksDeliveryStatus: "0", isDeliverSts: snacksOrderMode ?? "")
//                movieServices.ticketBookingApi(movieId: "1", movieName: "SARKARUVAARIPAATA(TELUGU)", bookingDate: "2022-05-26", showTime: "06:50pm", theaterId: "7", screenId: "1", screenName: "SCREEN-5", screenZone: "ELITE", snackstatus: "0", numberOfTickets: "1", seatNo: "A6", movieAmt: "200.00", snacksAmount: "0", itemNames: "", totalAmt: "200.00", snacksItemId: "", snacksCatId: "", snacksQuantityId: "", snacksPrice: "", promocode: "", discountPrice: "200.00", snacksDeliveryAmt: "0", snacksDeliveryStatus: "0", isDeliverSts: "0")
             //  PaymentView()
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
                       
                  
                    
                }.foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height : 25)
            //    .frame(width: geometry.size.width*0.8, height: 35, alignment: .center)
             //   .padding(EdgeInsets(top: 10, left: -15, bottom: 10, right: -15))
                .padding(.vertical , 15)
                .padding(.horizontal,10)
                
                .background(Color.red)
                .cornerRadius(25)
            }.padding(.horizontal,10)
                .onAppear(){
                    if promoDataViewModel.promoId != ""{
                        storeDataViewModel.offerCalculationApi(promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice()) { result in
                            self.applyCouponData = result
                        }
                }
                }
            if razorPayShow ?? false{
                RazorPayMethod(amount : "\(String((Float(movieServices.calculateTotalPrice()) ?? 0.00) + Float(10.00)))",getPaymetId: {
                    
                })
            }
       
            
      }.foregroundColor(.white)
    }
    func getFinalPaymentProcessData() -> (String , String , String , String , String){
        var foodId = ""
        var categoryId = ""
        var foodName = ""
        var foodPrice = ""
        var foodQty = ""
     
        
        for i in storeDataViewModel.items{
            if foodId == ""{
                foodId = i.foodId ?? ""
                categoryId = (i.categoryId ?? "")
                foodName =  (i.foodName ?? "")
                foodPrice = (i.foodPrice ?? "")
                foodQty = (i.foodQuantity ?? "")
            }else{
                foodId = (foodId + "," + (i.foodId ?? ""))
                categoryId = (categoryId + "," + (i.categoryId ?? ""))
                foodName = (foodName + "," + (i.foodName ?? ""))
                foodPrice = (foodPrice + "," + (i.foodPrice ?? ""))
                foodQty = (foodQty + "," + (i.foodQuantity ?? ""))
            }
        }
        return (foodId , categoryId , foodName , foodPrice , foodQty)
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
