//
//  CheckoutView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/05/22.
//

import SwiftUI
import Razorpay

struct CheckoutView: View {
    @EnvironmentObject var movieServices:MovieServices
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    @EnvironmentObject var promoDataViewModel : PromoViewModel
    @State var applyCouponData : PromoAmtCalculateModel?
    @State var razorPayShow : Bool? = false
    @State var snacksOrderMode : String? = "1"
    @State var snacksDeliveryTime : String? = "1"
    @State var showingAlert = false
    @State var moveTicketReciptView : Bool = false
    @State var calculateTotalPrice : String? = ""
    @State var bookingConfirmId = ""
    @State var seatConfirmId  = ""
    @State var errorPopup : Bool? = false
    @State var toastMsg : String = "Not valid"
    @State var showLoader : Bool = false
    @Environment(\.rootPresentationMode)  var rootPresentationMode: Binding<RootPresentationMode>
    var body: some View {
//        GeometryReader { geometry in
        ZStack(alignment:.bottom){
        ScrollView(showsIndicators:false){
            VStack {
                VStack {
                    HStack(alignment: .center) {
                        Button(action:{
                            showingAlert = true
                          //  self.presentationMode.wrappedValue.dismiss()
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
                    HStack(spacing : 20){
                        Text(movieServices.checkoutDetails?.movieName ?? "")
                            .font(Font.system(size: 20)).fontWeight(.bold).lineLimit(nil)
                        if movieServices.checkoutDetails?.theatreName == "M1 Cinemas"{
                            Image("m1_cinemas")
                                .resizable().frame(width: UIScreen.main.bounds.width/2.2, height: 80)
                        }else{
                            Image("spice_cinemas")
                                .resizable().frame(width: UIScreen.main.bounds.width/2.2, height: 80)
                        }
                    }
                    CustomDivider()
                    
                    HStack {
                        Spacer()
                        VStack(alignment:.leading){
                            CheckoutHeadingView(header: "Theatre Name", value: movieServices.checkoutDetails?.theatreName ?? "Spice cinemas").padding(.bottom,10)
                            CheckoutHeadingView(header: "Date", value:  Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? "")).padding(.bottom,10)
                            CheckoutHeadingView(header: "Seat Row", value: ((movieServices.selectedSeats[0].ticketType ?? "") + " - " + (movieServices.checkoutDetails?.seatNo ?? "")))
                        }
                        Spacer()
                        VStack(alignment:.leading){
                            CheckoutHeadingView(header: "Screen Name", value: movieServices.checkoutDetails?.screenName ?? "SCREEN-5").padding(.bottom,10)
                            CheckoutHeadingView(header: "Show Time", value: movieServices.checkoutDetails?.showTime ?? "12:25 PM").padding(.bottom,10)
                            if storeDataViewModel.items.count != 0{
                                CheckoutHeadingView(header: "Snacks Order", value: "\(storeDataViewModel.items.count)")
                            }else{
                                CheckoutHeadingView(header: "", value: "")
                            }
                           
                           
                        }
                        Spacer()
                    }
                    CustomDivider()
                    if storeDataViewModel.items.count == 0{
                        
                    }else{
                        List{
                            ForEach((storeDataViewModel.items), id : \.self){ item in
                                
                                CartAddItemCell(itemNames: item.foodName, itemPrice: (Float(item.foodPrice ?? "0.00") ?? 0.00), itemQuantity: (Int(item.foodQuantity ?? "0") ?? 0),itemId: item.foodId , catId: item.categoryId, getDataValue:({
                                    if storeDataViewModel.items.count != 0{
                                    if promoDataViewModel.promoId != ""{
                                        storeDataViewModel.offerCalculationApi(promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice()) { result in
                                            self.applyCouponData = result
                                        }
                                    }
                                    }else{
                                       // if promoDataViewModel.promoId != ""{
                                            promoDataViewModel.promoId = ""
                                            promoDataViewModel.promoCode = ""
                                      //  }
                                    }
                                }))
                                .background(Color("ColorAppGrey"))
                                .frame(height: 70)
                                .cornerRadius(5)
                                .listRowBackground(Color.black)
                                //  .background(Color.black)
                            }
                        }.listStyle(GroupedListStyle())
                            .frame(height: UIScreen.main.bounds.height/4)
                        
                    }
                    if storeDataViewModel.items.count != 0{
                      
                        DeliveryButtonGroups(selectedId: "Deliver at Seat" , callback:  { selected in
                            if selected == "Deliver at Seat"{
                                snacksOrderMode = "1"
                            }else{
                                snacksOrderMode = "0"
                            }
                            print("Selected Gender is: \(selected)")
                        }).padding(.horizontal,15).padding(.vertical,10)
                    CustomDivider()
                        if snacksOrderMode == "1"{
                            DeliveryTimeGroups(selectedId : "Show Beginning", callback:  { selected in
                                if selected == "Show Beginning"{
                                    snacksDeliveryTime = "1"
                                }else{
                                    snacksDeliveryTime = "0"
                                }
                                print("Selected Gender is: \(selected)")
                            }).padding(.horizontal,15).padding(.vertical,10)
                        CustomDivider()
                        }
                  
                    }
                }
                if storeDataViewModel.items.count != 0{
                    VStack(alignment:.leading){
                        Text("Offers").foregroundColor(.white).fontWeight(.bold).padding(.horizontal,10).padding(.vertical,5)
                        if promoDataViewModel.promoId != ""{
                            HStack{
                                Text("Get \(applyCouponData?.data?.discoutPer ?? "")% Off up to ₹\(applyCouponData?.data?.discountMaxAmt ?? "")")
                                    .foregroundColor(.white)
                                Spacer()
                                Button{
                                    promoDataViewModel.promoId = ""
                                    promoDataViewModel.promoCode = ""
                                }label: {
                                    Text("Remove")
                                        .foregroundColor(.red)
                                        .fontWeight(.semibold)
                                }
                            }
                        }else{
                        HStack{
                            Text("Select a Promo code").foregroundColor(.white)
                            Spacer()
                            NavigationLink{
                                OffersApplyView(totalAmount: totalAmountFullCalculation(), orderDate: Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? ""))
                            } label: {
                                Text("View Offers").foregroundColor(.red)
                                
                            }
                        }.padding(.horizontal,10).padding(.vertical,5)
                    }
                        CustomDivider()
                    }
                }
                VStack{
                    CheckoutPriceView(header: "Ticket Price", value:"₹ \(movieServices.checkoutDetails?.totalPrice ?? "")")
                    if storeDataViewModel.items.count != 0{
                    CheckoutPriceView(header: "Snacks and Beverage Price", value:"₹ \(storeDataViewModel.calculateTotalPrice())")
                        if snacksOrderMode == "1"{
                            CheckoutPriceView(header: "Deliver Price", value: "₹ 10.0")
                        }
                        if promoDataViewModel.promoId != ""{
                            CheckoutPriceView(header: "Discount Price(\(promoDataViewModel.promoCode ?? ""))", value: "- ₹ \(applyCouponData?.data?.calculatedDiscountAmount ?? "0")")
                        }
                  
                    }
                    CustomDivider()
                    CheckoutPriceView(header: "Total Price", value: totalAmountFullCalculation())
                    CustomDivider()
                }.padding(.bottom,80)
                
               
            }
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true).onAppear(perform: {
           
        }).background(Color("ColorAppGrey"))
            Button{
               razorPayShow = true
              
//                movieServices.ticketBookingApi(movieId: "1", movieName: "SARKARUVAARIPAATA(TELUGU)", bookingDate: "2022-05-26", showTime: "06:50pm", theaterId: "7", screenId: "1", screenName: "SCREEN-5", screenZone: "ELITE", snackstatus: "0", numberOfTickets: "1", seatNo: "A6", movieAmt: "200.00", snacksAmount: "0", itemNames: "", totalAmt: "200.00", snacksItemId: "", snacksCatId: "", snacksQuantityId: "", snacksPrice: "", promocode: "", discountPrice: "200.00", snacksDeliveryAmt: "0", snacksDeliveryStatus: "0", isDeliverSts: "0")
             //  PaymentView()
            } label: {
                HStack(spacing :20){
                    Text("PROCEED PAYMENT")
                    .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(height: 100)
                    Spacer()
                    Text("₹ \(totalAmountFullCalculation())")
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
                .toast(isShowing: $errorPopup,textContent: toastMsg)
                    .loaderView(isShowing: $showLoader)
            if razorPayShow ?? false{
                RazorPayMethod(amount : totalAmountFullCalculation(),getPaymetId: {
                    showLoader = true
                    var calculateTotalAmount : Float = 0.00
                   
                    
                    if storeDataViewModel.items.count == 0{
                        snacksOrderMode = "0"
                        snacksDeliveryTime = "1"
                        calculateTotalAmount = (Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00)
                    }else{
                       
                        if snacksOrderMode == "1"{
                            calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00))
                        }else{
                            snacksDeliveryTime = "1"
                            calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00))
                        }
                    }

                    self.calculateTotalPrice = String(calculateTotalAmount)
                    let paymentData = getFinalPaymentProcessData()
                    movieServices.ticketBookingApi(movieId: "1", movieName: movieServices.checkoutDetails?.movieName ?? "", bookingDate: Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? ""), showTime: movieServices.checkoutDetails?.showTime ?? "", theaterId: (movieServices.checkoutDetails?.theatreName ?? "") == "Spice  Cinemas" ? "7" : "8", screenId: "1", screenName: (movieServices.checkoutDetails?.screenName ?? "").removeWhitespace(), screenZone: movieServices.selectedSeats[0].ticketType ?? "", snackstatus: storeDataViewModel.items.count == 0 ? "0" : "1", numberOfTickets: String(movieServices.selectedSeats.count), seatNo: movieServices.calculateSeats().removeWhitespace(), movieAmt: String((Int(movieServices.checkoutDetails?.ticketPrice ?? "") ?? 0) * (movieServices.selectedSeats.count)), snacksAmount: storeDataViewModel.calculateTotalPrice(), itemNames: paymentData.2, totalAmt: String(format: "%.2f", calculateTotalAmount) , snacksItemId: paymentData.0, snacksCatId: paymentData.1, snacksQuantityId: paymentData.4, snacksPrice: paymentData.3, promocode: promoDataViewModel.promoCode ?? "", discountPrice: ((promoDataViewModel.promoId == "") ? "" : String(applyCouponData?.data?.calculatedDiscountAmount ?? "") ) , snacksDeliveryAmt: snacksOrderMode == "0" ? "0" : "10", snacksDeliveryStatus: "0", isDeliverSts: snacksDeliveryTime ?? "" , totalAmtAfterDiscount: totalAmountFullCalculation(), completionHandler : ({ result in
                        seatConfirmId = String(result.seatConfirmID ?? 0)
                    //    let requestModel = [
//                            "movie": movieServices.checkoutDetails?.movieName ?? "" ,"showTime":movieServices.checkoutDetails?.showTime ?? "" , "theatre" : (movieServices.checkoutDetails?.theatreName ?? "") == "Spice  Cinemas" ? "7" : "8" , "seat" : (movieServices.selectedSeats[0].ticketType ?? "" + " - " + movieServices.calculateSeats().removeWhitespace()) , "screen" : (movieServices.checkoutDetails?.screenName ?? "").removeWhitespace() ,"showDate" : Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? "") , "seatAmt" :  String((Int(movieServices.checkoutDetails?.ticketPrice ?? "") ?? 0) * (movieServices.selectedSeats.count)) , "totalAmt" : String(format: "%.2f", calculateTotalAmount) , "snackData" : (paymentData.4 + " x " + paymentData.2) , "deliverAmt" : snacksOrderMode == "0" ? "" : "10.00","orderId" : "" , "usermail" : StorageSettings().emailAddress , "snacks_delivery_amt" : snacksOrderMode == "0" ? "₹ 0" : "₹ 10" , "calculated_discount_amount" : "" ,
                                            //"strCinemaCode" : movieServices.selectedScreen?.show.cinemaStrID ?? "" ,
                                            //"strTransId" :  movieServices.seatLayouts?.strTransID ?? "" ,"lngSessionId" : "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )",
                                      //     ]
//                        moveTicketReciptView = true
//                        var transactionId = ""
//                        for value in movieServices.selectedSeats{
//                            transactionId += ((value.strTransId ?? "") + ",")
//                        }
//                        transactionId.removeLast()
                        var addedCount = 0
                        for i in movieServices.selectedSeats{
                            movieServices.confirmSeatsApi( transactionId : i.strTransId ?? "" , sessionId :  "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )" , cinemaCOde : movieServices.selectedScreen?.show.cinemaStrID ?? "") { finalResult in
                                bookingConfirmId += "\(String(finalResult.data?.strBookId ?? "")),"
                                 addedCount+=1
                                if addedCount == movieServices.selectedSeats.count{
                                    bookingConfirmId = String(bookingConfirmId.dropLast())
                                    bookingidChangeApi(id : bookingConfirmId)
                                }
                            }
                        }

                        
                    }))
                })
            }
            NavigationLink(destination: TicketReciptView(lastPage: "checkout" , movieName: movieServices.checkoutDetails?.movieName ?? "", showDate: Common.sharedInstance.changeFormatMonthAndYear(item: movieServices.checkoutDetails?.date ?? ""), showTime: movieServices.checkoutDetails?.showTime ?? "" , theatreName: (movieServices.checkoutDetails?.theatreName ?? "") , screenName: (movieServices.checkoutDetails?.screenName ?? "") , seatNumber: ((movieServices.selectedSeats[0].ticketType ?? "") + "- " +  movieServices.calculateSeats().removeWhitespace()), bookingId: bookingConfirmId , snacksName: ((getFinalPaymentProcessData().1) + " x " + (getFinalPaymentProcessData().2)), ticketPrice: String((Int(movieServices.checkoutDetails?.ticketPrice ?? "") ?? 0) * (movieServices.selectedSeats.count)), snacksprice: storeDataViewModel.calculateTotalPrice(), deliverPrice: snacksOrderMode == "0" ? "" : "10", totalPrice: totalAmountFullCalculation() , discountAmount:  (applyCouponData?.data?.calculatedDiscountAmount ?? "0")), isActive: $moveTicketReciptView){
           
            }.isDetailLink(false)
         
      }.foregroundColor(.white)
            .alert(isPresented: $showingAlert){
                Alert(
                    title: Text("CONFIRMATION"),
                    message: Text("Do you want to end the session"),
                    primaryButton: .default(Text("Yes"), action: {
                        storeDataViewModel.deleteAllDatas()
                        resetSeatMultipleSeats()
                        rootPresentationMode.wrappedValue.dismiss()
                    }),
                    secondaryButton: .cancel(Text("Cancel"), action: { // 1
                        showingAlert = false
                        
                    })
                )
            }
    }
    func bookingidChangeApi(id : String){
        movieServices.finalOrderBookingApi(seatConfirmId: seatConfirmId , bookConfirmId: id , completionHandler: { finalResult in
            
           
            toastMsg = "Ticket booked sucessfully"
            errorPopup = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showLoader = false
                promoDataViewModel.promoCode = ""
                promoDataViewModel.promoId = ""
              //  storeDataViewModel.deleteAllDatas()
                moveTicketReciptView = true
            }
          
          //  movieServices.selectedSeats = []
          //  storeDataViewModel.deleteAllDatas()

        })
    }
    func resetSeatMultipleSeats(){
        
            let filteredArray = movieServices.selectedSeats.filter { value in
              //  if value.strTransId != nil{
                    movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
                    return false
             //   }
          
            }
         //   movieServices.selectedSeats = []
      //  }
       
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
    func totalAmountFullCalculation() -> String{
        var calculateTotalAmount : Float = 0.00
        if storeDataViewModel.items.count == 0{
            calculateTotalAmount = (Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00)
        }else{
            if promoDataViewModel.promoId != ""{
                
                if snacksOrderMode == "1"{
                    calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(applyCouponData?.data?.discountedAmountFromTotal ?? "0") ?? 0.00) + Float(10.00))
                }else{
                    calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(applyCouponData?.data?.discountedAmountFromTotal ?? "0") ?? 0.00))
                }
               
            }else{
            if snacksOrderMode == "1"{
                calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00))
            }else{
                calculateTotalAmount = ((Float(movieServices.checkoutDetails?.totalPrice ?? "") ?? 0.00) + (Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00))
            }
        }
        }
        return String(format: "%.2f", calculateTotalAmount)
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
                .fontWeight(.bold)
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
struct BookTicketRazorPay: UIViewControllerRepresentable {
    var amount = "0"
    var getPaymetId : () -> ()
  
    func makeUIViewController(context: Context) -> CheckoutViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, getPaymetId , amount)
    }

    class Coordinator: NSObject, RazorpayPaymentCompletionProtocol {
        let parent: BookTicketRazorPay
        var getPaymetId : () -> ()
        var amount = "0"
        typealias Razorpay = RazorpayCheckout
        var razorpay: RazorpayCheckout!
        
        init(_ parent: BookTicketRazorPay ,_ getPaymetId : @escaping () -> () ,_ amount : String) {
            self.parent = parent
            self.getPaymetId = getPaymetId
            self.amount = amount
            super.init()
            razorpay =  RazorpayCheckout.initWithKey("rzp_test_F0OI03VaPbNCHU", andDelegate: self)
          //  razorpay =  RazorpayCheckout.initWithKey("rzp_live_y6W3EW6yAFrjkQ", andDelegate: self)
            //rzp_live_y6W3EW6yAFrjkQ
            //rzp_test_F0OI03VaPbNCHU     rzp_live_vq8tmnnZmbWVkx
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let options: [String:Any] = [
                    "amount": String("\((Float(amount) ?? 0.00) * 100.00)"), //This is in currency subunits. 100 = 100 paise= INR 1.
                            "currency": "INR",//We support more that 92 international currencies.
                            "description": "KFE Cinemas",
                            "image": "https://cdn3.ticketnew.com/partners/img/kfecinemas/logo.png?v8",
                            "name": "KFE",
                            "prefill": [
                                "contact": StorageSettings().mobileNumber,
                                "email": StorageSettings().emailAddress
                            ],
                            "theme": [
                                "color": "#F37254"
                            ]
                        ]
                self.razorpay.open(options)
//                if let rzp = self.razorpay {
//                    rzp.open(options)
//                } else {
//                    print("Unable to initialize")
//                }// your code here
            }
            
        }
        
        func onPaymentError(_ code: Int32, description str: String) {
              print("error: ", code, str)
           //   self.presentAlert(withTitle: "Alert", message: str)
            // parent.alert with message
          }

          func onPaymentSuccess(_ payment_id: String) {
              print("success:view ", payment_id)
              getPaymetId()
           //   self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
          }
    }
}
