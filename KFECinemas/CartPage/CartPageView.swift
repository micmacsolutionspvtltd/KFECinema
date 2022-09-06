 
//
//  CartView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//
import SwiftUI
import Razorpay
struct CartPageView: View {
    @Environment(\.presentationMode) private var presentationMode : Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
 //   @State private var isActive : Bool = false
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    @EnvironmentObject var promoDataViewModel : PromoViewModel
    @State var deliveryCLicked : Bool = true
    @State var collectionClicked : Bool = false
    @State var getTotalAmount : String = ""
    @State private var birthDate = Date()
    @State var clickBookingDate : Bool = false
    @State var dateOfclick : String? = ""
    @State var selectionMovieDate : Date? = Date.now
    @State var razorPayShow : Bool? = false
   @State var theaterNames = ["M1 Cinemas", "Spice Cinemas"]
    @State var screenNames  = ["Screen 1", "Screen 2", "Screen 3", "Screen 4", "Screen 5"]
    var showTimes = ["Noon Show", "Matinee Show", "Evening Show", "Night Show", "Special Show"]
    @State var seatArea = ["Premium", "Elite", "Gold"]
    var takeAwatTime = ["15 Mins", "30 Mins", "45 Mins", "60 Mins"]
    @State var pageNames : String?
    @State var selectedTheaterName : String? = "Spice Kitchen"
    @State var selectedScreenName : String? = ""
    @State var selectTakeeAwatTime : String? = ""
    @State var selectedShowTime : String? = ""
    @State var selectedSeatArea : String? = ""
    @State var seatNo : String = ""
    @State var applyCouponData : PromoAmtCalculateModel?
    @State var moveToDashBoard : Bool = false
    @State var errorPopup : Bool? = false
    @State var toastMsg : String = "Not valid"
    @State var showLoader : Bool = false
    @State var theaterId : String = ""
    var body: some View {
        //
        GeometryReader { geometry in
            
            ZStack{
                ScrollView {
                    VStack{
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
                                            storeDataViewModel.deleteAllDatas()
                                            promoDataViewModel.promoId = ""
                                            promoDataViewModel.promoCode = ""
                                            NavigationUtil.popToRootView()
                                           // rootPresentationMode.wrappedValue.dismiss()
                                            //  presentationMode.wrappedValue.dismiss()
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
                            if storeDataViewModel.items.count == 0{
                                
                            }else{
                                List{
                                    ForEach((storeDataViewModel.items), id : \.self){ item in
                                        
                                        CartAddItemCell(itemNames: item.foodName, itemPrice: (Float(item.foodPrice ?? "0.00") ?? 0.00), itemQuantity: (Int(item.foodQuantity ?? "0") ?? 0),itemId: item.foodId , catId: item.categoryId, getDataValue:({
                                            if promoDataViewModel.promoId != ""{
                                                storeDataViewModel.offerCalculationApi(promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice()) { result in
                                                    self.applyCouponData = result
                                                }
                                            }
                                        }))
                                        .background(Color("ColorAppGrey"))
                                        .frame(height: 70)
                                        .cornerRadius(5)
                                        .listRowBackground(Color.black)
                                        //  .background(Color.black)
                                    }
                                }.listStyle(GroupedListStyle())
                                    .frame(height: geometry.size.height/4)
                                
                            }
                        }
                        
                        VStack{
                            ScrollView{
                                Divider()
                                    .frame(height: 2)
                                    .background(Color.white.opacity(0.7))
                                
                                HStack{
                                    Button{
                                        deliveryCLicked = true
                                        collectionClicked = false
                                        selectedTheaterName = selectedTheaterName ?? "Spice Kitchen"
                                        selectedScreenName = ""
                                        selectedSeatArea = ""
                                        selectedShowTime = ""
                                    }  label:{
                                        HStack{
                                            
                                            Image(systemName: deliveryCLicked ? "circle.circle.fill" : "circle")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.white)
                                            Text("Deliver at Seat")
                                                .foregroundColor(.white)
                                            
                                        }.frame(width: 150,alignment: .leading)
                                            .padding([.leading],5)
                                    }
                                    Button{
                                        deliveryCLicked = false
                                        collectionClicked = true
                                        selectedTheaterName = selectedTheaterName ?? "Spice Kitchen"
                                        selectedScreenName = ""
                                        selectedSeatArea = ""
                                        seatNo = ""
                                        selectedShowTime = ""
                                        selectTakeeAwatTime = ""
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
                                        NavigationLink{
                                            OffersApplyView(totalAmount: storeDataViewModel.calculateTotalPrice(), orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now, dateFormat: "yyyy-MM-dd"))
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
                                    }
                                    
                                    
                                    Divider()
                                        .frame(height: 2)
                                        .background(Color.white.opacity(0.7))
                                        .padding([.bottom],20)
                                }
                                .background(Color.black)
                                if deliveryCLicked{
                                    VStack{
                                        CartItemContentView(selectedItemName: $dateOfclick, tittleText: "Date Of Order", buttonName: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now, dateFormat: "dd-MM-yyyy"), imageName: "calendar" ,getDataValue: {
                                       
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedTheaterName, tittleText: "Theatre Name", buttonName: selectedTheaterName ?? "Spice Kitchen", imageName: "calendar" ,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedScreenName, tittleText: "Screen Name", buttonName: "Select Screen", imageName: "chevron.down", dropDownDatas : screenNames,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedShowTime, tittleText: "Show time", buttonName: "Select Show", imageName: "chevron.down", dropDownDatas : showTimes,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedSeatArea, tittleText: "Seat Area", buttonName: "Select SeatArea", imageName: "chevron.down" , dropDownDatas : seatArea ,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        
                                        VStack(alignment : .leading){
                                            HStack{
                                                Text("Enter Seat No")
                                                    .frame(alignment: .leading)
                                                Spacer()
                                                HStack{
                                                    ZStack{
                                                        
                                                        TextField("", text: $seatNo)
                                                            .placeholder(when: seatNo.isEmpty) {
                                                                Text("Ex : S1,S2,S3").foregroundColor(.white).opacity(0.4)
                                                            }.foregroundColor(Color.white).frame(width: 100, height: 30, alignment: .center).multilineTextAlignment(.center).foregroundColor(Color.white)
                                                            .background(Color("ColorAppGrey"))
                                                    }.frame(width: 150, height: 25)
                                                        .padding()
                                                        .background(Color("ColorAppGrey")).cornerRadius(.infinity)
                                                        .overlay(
                                                            RoundedRectangle(cornerRadius: .infinity)
                                                                .stroke(Color.red, lineWidth: 2)
                                                        )
                                                }
                                                
                                            }.foregroundColor(Color.white)
                                            
                                        }.frame(width: geometry.size.width, height: 70)
                                    }
                                    VStack(spacing : 5){
                                        HStack{
                                            Text("Item Total")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                        HStack{
                                            Text("Delivery Charge")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("₹ 10.00")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                        if promoDataViewModel.promoId != ""{
                                            HStack{
                                                HStack{
                                                    Text("Discount Price")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.white)
                                                    Text(promoDataViewModel.promoCode ?? "")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                                Text("- ₹ \(applyCouponData?.data?.calculatedDiscountAmount ?? "0")")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                            HStack{
                                                Text("Grand Total")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("₹ \((String((Float(applyCouponData?.data?.discountedAmountFromTotal ?? "0.00") ?? 0.00) + 10.00)))")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                        }else{
                                            HStack{
                                                Text("Grand Total")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("₹ \(String((Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00)))")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        
                                    }.frame(width: geometry.size.width)
                                        .padding([.bottom],100)
                                }else{
                                    VStack{
                                        
                                        CartItemContentView(selectedItemName: $dateOfclick, tittleText: "Date Of Order", buttonName: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now, dateFormat: "dd-MM-yyyy") , imageName: "calendar" ,getDataValue: {
                                            // clickBookingDate = true
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectTakeeAwatTime, tittleText: "Takeaway Time", buttonName: "Select time", imageName: "chevron.down" , dropDownDatas : takeAwatTime,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                    }
                                    VStack(spacing : 5){
                                        HStack{
                                            Text("Item Total")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                        if promoDataViewModel.promoId != ""{
                                            HStack{
                                                HStack{
                                                    Text("Discount Price")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.white)
                                                    Text(promoDataViewModel.promoCode ?? "")
                                                        .fontWeight(.semibold)
                                                        .foregroundColor(.gray)
                                                }
                                                
                                                Spacer()
                                                Text("- ₹ \(applyCouponData?.data?.calculatedDiscountAmount ?? "0")")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                            HStack{
                                                Text("Grand Total")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("₹ \(String(applyCouponData?.data?.discountedAmountFromTotal ?? "0"))")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                        }else{
                                            HStack{
                                                Text("Grand Total")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                        
                                    }.frame(width: geometry.size.width)
                                        .padding([.bottom],100)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                Button{
                    if deliveryCLicked{
                        if selectedTheaterName == ""{
                            toastMsg = Constants.CheckoutKeys.selectTheaterName
                            errorPopup = true
                            return
                        }else if selectedScreenName == ""{
                            toastMsg = Constants.CheckoutKeys.selectScreenName
                            errorPopup = true
                            return
                        }else if selectedSeatArea == ""{
                            toastMsg = Constants.CheckoutKeys.selectSeatArea
                            errorPopup = true
                            return
                        }else if selectedShowTime == ""{
                            toastMsg = Constants.CheckoutKeys.selectShowTime
                            errorPopup = true
                            return
                        }else if seatNo == ""{
                            toastMsg = Constants.CheckoutKeys.seatNo
                            errorPopup = true
                            return
                        }
                    }else{
                        if selectTakeeAwatTime == ""{
                            toastMsg = Constants.CheckoutKeys.selectTakeAwayTime
                            errorPopup = true
                            return
                        }
                    }
                    
                    razorPayShow = true
                    
                    
                } label: {
                    HStack{
                        //.fontWeight(.bold)
                        Text("PROCEED TO PAYMENT")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 5))
                        
                        // Spacer()
                        if promoDataViewModel.promoId != ""{
                            if deliveryCLicked{
                                Text("₹ \(String((Int(applyCouponData?.data?.discountedAmountFromTotal ?? "0") ?? 0) + 10))")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }else{
                                Text("₹ \(String((applyCouponData?.data?.discountedAmountFromTotal ?? "0")))")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }
                            
                        }else{
                            if deliveryCLicked{
                                Text("₹ \(String((Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00)))")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }else{
                                Text("₹ \(String((Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00)))")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }
                            
                        }
                    }
                    .frame(width: geometry.size.width*0.8, height: 25, alignment: .center)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(.infinity)
                }.position(x: geometry.size.width/2, y: geometry.size.height/1.05)
                if clickBookingDate{
                    DatePickerWithButtons(showDatePicker: $clickBookingDate, savedDate: $selectionMovieDate, selectedDate: selectionMovieDate ?? Date())
                        .animation(.linear)
                        .transition(.opacity)
                }
                if razorPayShow ?? false{
                    
                    RazorPayMethod(amount : calculateAmount(),getPaymetId: { result in
                        if result == "Failure"{
                            toastMsg = "Payment failed please try again"
                            errorPopup = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                NavigationUtil.popToRootView()
                            }
                        }else{
                        showLoader = true
                        let paymentData = getFinalPaymentProcessData()
                        //   PaymentView()
                        if pageNames == "Spice Kitchen"{
                            //                        storeDataViewModel.orderFoodItem(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), itemId: "", categoryId: "", quantity: "", price: "", gst: "", promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName ?? "", screenId: selectedScreenName ?? "", seatNo: seatNo, totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "", discountPrice: storeDataViewModel.calculateTotalPrice()) { result in
                            //
                            //                        }
                            storeDataViewModel.orderSnackItem(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now , dateFormat : "yyyy-MM-dd"), itemId: paymentData.0, categoryId: paymentData.1 , quantity: paymentData.4, price: paymentData.3, gst: paymentData.0, promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName ?? "", screenId: selectedScreenName ?? "", seatNo: seatNo, totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: selectedShowTime ?? "", seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "", discountPrice: calculateAmount() , amountDiscounted : ((promoDataViewModel.promoId == "") ? "" : String(applyCouponData?.data?.calculatedDiscountAmount ?? "0")) ) { result in
                                toastMsg = "Ordered sucessfully completed"
                                errorPopup = true
                               
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    storeDataViewModel.deleteAllDatas()
                                    promoDataViewModel.promoId = ""
                                    promoDataViewModel.promoCode = ""
                                    showLoader = false
                                    NavigationUtil.popToRootView()
//                                    rootPresentationMode.wrappedValue.dismiss()
//                                    presentationMode.wrappedValue.dismiss()
                                 //   moveToDashBoard = true
                                }
                               
                                //   moveToDashBoard = true
                            }
                        }else{
                            //                        storeDataViewModel.orderSnackItem(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), itemId: "2", categoryId: "2", quantity: "1", price: storeDataViewModel.calculateTotalPrice(), gst: "1", promoId: promoDataViewModel.promoId ?? "25", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName?.removeWhitespace() ?? "", screenId: selectedScreenName?.removeWhitespace() ?? "", seatNo: "E5", totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "prom67", discountPrice: storeDataViewModel.calculateTotalPrice()) { result in
                            //
                            //                        }
                            storeDataViewModel.confirmSnacksItem(cinemaCOde : theaterId, itemID: getFinalFoodID().0) { result in
                                storeDataViewModel.orderConcessionZoneSnacks(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now , dateFormat : "yyyy-MM-dd"), itemId: paymentData.0, categoryId: "4" , quantity: paymentData.4, price: paymentData.3, gst: paymentData.0, promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName ?? "", screenId: selectedScreenName ?? "", seatNo: seatNo, totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: selectedShowTime ?? "" , seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "", discountPrice: calculateAmount() , amountDiscounted : ((promoDataViewModel.promoId == "") ? "" : String(applyCouponData?.data?.calculatedDiscountAmount ?? "0")), orderConfirmId: result.data?.curItemsID ?? "") { result in
                                    toastMsg = "Ordered sucessfully completed"
                                    errorPopup = true
                                     DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    storeDataViewModel.deleteAllDatas()
                                    promoDataViewModel.promoId = ""
                                    promoDataViewModel.promoCode = ""
                                    showLoader = false
                                         NavigationUtil.popToRootView()
    //                                rootPresentationMode.wrappedValue.dismiss()
    //                                     presentationMode.wrappedValue.dismiss()
                                        // moveToDashBoard = true
                                     }
                                    //  moveToDashBoard = true
                                }
                            }

                        }
                    }
                    })
                }
            }.toast(isShowing: $errorPopup,textContent: toastMsg , backGroundColor : Color.white)
                .loaderView(isShowing: $showLoader)
                .background(Color.black)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onAppear(){
                    if selectedTheaterName == "Spice Cinemas"{
                        seatArea = ["Elite"]
                        screenNames = ["Screen 1", "Screen 2", "Screen 3"]
                    }else{
                        seatArea = ["Premium", "Elite", "Gold"]
                        screenNames = ["Screen 1", "Screen 2", "Screen 3", "Screen 4", "Screen 5"]
                    }
                    if promoDataViewModel.promoId != ""{
                        storeDataViewModel.offerCalculationApi(promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice()) { result in
                            self.applyCouponData = result
                        }
                    }else{
                        
                    }
                    
                }
//            NavigationLink(destination: Dashboard(), isActive: $moveToDashBoard) {
//                
//            }
            
        }
        
        
    }
    func calculateAmount() -> (String){
        var calculateFullAmount = ""
        if promoDataViewModel.promoId != ""{
            if deliveryCLicked{
                calculateFullAmount = String((Int(applyCouponData?.data?.discountedAmountFromTotal ?? "0") ?? 0) + 10)
             
        }else{
            calculateFullAmount =  (String((applyCouponData?.data?.discountedAmountFromTotal ?? "0")))
        }
            
       
        }else{
            if deliveryCLicked{
               calculateFullAmount = (String((Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) + Float(10.00)))
            }else{
                calculateFullAmount = (String((Float(storeDataViewModel.calculateTotalPrice()) ?? 0.00) ))
            }
        }
        return calculateFullAmount
    }
    func getFinalFoodID() -> (String , String){
        var finalId = ""
        var nameAndQuantity = ""
        var foodId = ""
        var foodQty = ""
     
        
        for i in storeDataViewModel.items{
            nameAndQuantity += "\(i.foodQuantity ?? "") x \(i.foodName ?? ""),"
            if foodId == ""{
                foodId = ("|" + String(storeDataViewModel.items.count) + "|" + (i.foodId ?? "") + "|")
                foodQty = ((i.foodQuantity ?? "") + "|-1|")
               
            }else{
                foodId = ((i.foodId ?? "") + "|")
                foodQty = ((i.foodQuantity ?? "") + "|-1|")
            }
            finalId += foodId + foodQty
            nameAndQuantity = String(nameAndQuantity.dropLast())
        }
        return (finalId , nameAndQuantity)
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

struct CartPageView_Previews: PreviewProvider {
    static var previews: some View {
        CartPageView()
            .background(Color.black)
    }
}

struct RazorPayMethod: UIViewControllerRepresentable {
    var amount = "0"
    var getPaymetId : (String) -> ()
  
    func makeUIViewController(context: Context) -> CheckoutViewController {
        .init()
    }

    func updateUIViewController(_ uiViewController: CheckoutViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, getPaymetId , amount)
    }

    class Coordinator: NSObject, RazorpayPaymentCompletionProtocol {
        let parent: RazorPayMethod
        var getPaymetId : (String) -> ()
        var amount = "0"
        typealias Razorpay = RazorpayCheckout
        var razorpay: RazorpayCheckout!
        
        init(_ parent: RazorPayMethod ,_ getPaymetId : @escaping (String) -> () ,_ amount : String) {
            self.parent = parent
            self.getPaymetId = getPaymetId
            self.amount = amount
            super.init()
            razorpay =  RazorpayCheckout.initWithKey("rzp_test_F0OI03VaPbNCHU", andDelegate: self)
        //    razorpay =  RazorpayCheckout.initWithKey("rzp_live_y6W3EW6yAFrjkQ", andDelegate: self)

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
            getPaymetId("Failure")
           //   self.presentAlert(withTitle: "Alert", message: str)
            // parent.alert with message
          }

          func onPaymentSuccess(_ payment_id: String) {
              print("success:view ", payment_id)
              getPaymetId("Sucess")
           //   self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
          }
    }
}
