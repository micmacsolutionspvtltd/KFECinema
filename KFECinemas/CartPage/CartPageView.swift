 
//
//  CartView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//
import SwiftUI

struct CartPageView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    @EnvironmentObject var promoDataViewModel : PromoViewModel
    @State var deliveryCLicked : Bool = true
    @State var collectionClicked : Bool = false
    @State var getTotalAmount : String = ""
    @State private var birthDate = Date()
    @State var clickBookingDate : Bool = false
    @State var dateOfclick : String? = ""
    @State var selectionMovieDate : Date? = Date.now
    
    var theaterNames = ["M1 Cinemas", "Spice Cinemas"]
    var screenNames = ["Screen 1", "Screen 2", "Screen 3", "Screen 4", "Screen 5"]
    var showTimes = ["11.30 AM", "03.00 PM", "06.30 PM", "09.45 PM"]
    var seatArea = ["Premium", "Elite", "Gold"]
    var takeAwatTime = ["15 Mins", "30 Mins", "45 Mins", "1 Hour"]
    @State var pageNames : String?
    @State var selectedTheaterName : String?
    @State var selectedScreenName : String?
    @State var selectTakeeAwatTime : String?
    @State var selectedShowTime : String?
    @State var selectedSeatArea : String?
    @State var seatNo : String = ""
    @State var applyCouponData : PromoAmtCalculateModel?
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
                                            promoDataViewModel.promoId = ""
                                            presentationMode.wrappedValue.dismiss()
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
                                            //  dbViewModel.getAllDataFromTable()
                                            //   getTotalAmount = calculatingTotalPrice()
                                        }))
                                        .background(Color("ColorAppGrey"))
                                        .frame(height: 70)
                                        .cornerRadius(5)
                                        .listRowBackground(Color.black)
                                      //  .background(Color.black)
                                    }
                                }.listStyle(GroupedListStyle())
                                    .frame(height: geometry.size.height/2)
                                   
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
                                        selectedTheaterName = theaterNames[0]
                                        selectedScreenName = screenNames[0]
                                        selectedSeatArea = seatArea[0]
                                        
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
                                        selectedTheaterName = ""
                                        selectedScreenName = ""
                                        selectedSeatArea = ""
                                        seatNo = ""
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
                                            }label: {
                                                Text("Remove")
                                                    .foregroundColor(.red)
                                                    .fontWeight(.semibold)
                                            }
                                        }
                                    }else{
                                        NavigationLink{
                                            OffersApplyView(totalAmount: storeDataViewModel.calculateTotalPrice(), orderDate: selectionMovieDate)
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
                                        CartItemContentView(selectedItemName: $dateOfclick, tittleText: "Date Of Order", buttonName: Date().currentDateOnly, imageName: "calendar" ,getDataValue: {
                                            clickBookingDate = true
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedTheaterName, tittleText: "Theatre Name", buttonName: theaterNames[0], imageName: "chevron.down", dropDownDatas : theaterNames,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedScreenName, tittleText: "Select Screen Name", buttonName: screenNames[0], imageName: "chevron.down", dropDownDatas : screenNames,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedShowTime, tittleText: "Select Show", buttonName: showTimes[0], imageName: "chevron.down", dropDownDatas : showTimes,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectedSeatArea, tittleText: "Select Seat Area", buttonName: seatArea[0], imageName: "chevron.down" , dropDownDatas : seatArea ,getDataValue: {
                                            
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        
                                        VStack(alignment : .leading){
                                            HStack{
                                                Text("Select Seat No")
                                                    .frame(alignment: .leading)
                                                Spacer()
                                                HStack{
                                                    ZStack{
                                                        
                                                        HStack{
                                                            Spacer()
                                                            Image(systemName: "chevron.down")
                                                                .foregroundColor(.white)
                                                                .frame(width: 20, height: 20)
                                                        }
                                                        TextField("", text: $seatNo)
                                                            .placeholder(when: seatNo.isEmpty) {
                                                                Text("Ex : S1,S2,S3").foregroundColor(.white).opacity(0.4)
                                                            }.foregroundColor(Color.white).frame(width: 100, height: 30, alignment: .center).multilineTextAlignment(.center).foregroundColor(Color.white)
                                                            .background(Color("ColorAppGrey"))
                                                    }.frame(width: 150, height: 25)
                                                        .padding()
                                                        .background(Color("ColorAppGrey"))
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
                                                Text("- ₹ \(applyCouponData?.data?.discountMaxAmt ?? "")")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                            }
                                            HStack{
                                                Text("Grand Total")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                Spacer()
                                                Text("₹ \((String(Float(applyCouponData?.data?.discountedAmountFromTotal ?? 0) + 10.00)))")
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
                                        
                                        CartItemContentView(selectedItemName: $dateOfclick, tittleText: "Date Of Order", buttonName: Date().currentDateOnly, imageName: "calendar" ,getDataValue: {
                                            clickBookingDate = true
                                        })
                                        .frame(width: geometry.size.width, height: 70)
                                        CartItemContentView(selectedItemName: $selectTakeeAwatTime, tittleText: "Select Takeaway Time", buttonName: takeAwatTime[0], imageName: "chevron.down" , dropDownDatas : takeAwatTime,getDataValue: {
                                            
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
                                        
                                        HStack{
                                            Text("Grand Total")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                        }
                                    }.frame(width: geometry.size.width)
                                        .padding([.bottom],100)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                Button{
                    if pageNames == "Spice Kitchen"{
                        storeDataViewModel.orderFoodItem(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), itemId: "", categoryId: "", quantity: "", price: "", gst: "", promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName ?? "", screenId: selectedScreenName ?? "", seatNo: seatNo, totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "", discountPrice: storeDataViewModel.calculateTotalPrice()) { result in
                            
                        }
                    }else{
                        storeDataViewModel.orderSnackItem(orderDate: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), itemId: "", categoryId: "", quantity: "", price: "", gst: "", promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice(), pickUpCounter: deliveryCLicked ? "1" : "0", theaterId: selectedTheaterName ?? "", screenId: selectedScreenName ?? "", seatNo: seatNo, totalPrice: storeDataViewModel.calculateTotalPrice(), showTime: Common.sharedInstance.changingDateFormat(date: selectionMovieDate ?? Date.now), seatRow: selectedSeatArea ?? "", promoCode: promoDataViewModel.promoCode ?? "", discountPrice: storeDataViewModel.calculateTotalPrice()) { result in
                            
                        }
                    }
                    
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
                                Text("₹ \(String((applyCouponData?.data?.discountedAmountFromTotal ?? 0) + 10))")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                            }else{
                                Text("₹ \(String((applyCouponData?.data?.discountedAmountFromTotal ?? 0)))")
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
                }.position(x: geometry.size.width/2, y: geometry.size.height/1.07)
                if clickBookingDate{
                    DatePickerWithButtons(showDatePicker: $clickBookingDate, savedDate: $selectionMovieDate, selectedDate: selectionMovieDate ?? Date())
                        .animation(.linear)
                        .transition(.opacity)
                }
            }
            .background(Color.black)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(){
                if promoDataViewModel.promoId != ""{
                    storeDataViewModel.offerCalculationApi(promoId: promoDataViewModel.promoId ?? "", totalAmt: storeDataViewModel.calculateTotalPrice()) { result in
                        self.applyCouponData = result
                    }
                }else{
                    
                }
                
            }
        }
    }
    
    
}

struct CartPageView_Previews: PreviewProvider {
    static var previews: some View {
        CartPageView()
            .background(Color.black)
    }
}

