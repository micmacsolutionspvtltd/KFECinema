//
//  CartView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct CartPageView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
  //  @ObservedObject var dbViewModel = DatabaseViewModel()
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel

    @State var deliveryCLicked : Bool = true
    @State var collectionClicked : Bool = false
    @State var getTotalAmount : String = ""
    @State private var birthDate = Date()
    @State var clickBookingDate : Bool = false
    @State var selectionMovieDate : Date? = Date.now
    var theaterNames = ["M1 Cinemas", "Spice Cinemas"]
    var screenNames = ["Screen 1", "Screen 2", "Screen 3", "Screen 4", "Screen 5"]
    var showTimes = ["11.30 AM", "03.00 PM", "06.30 PM", "09.45 PM"]
    var seatArea = ["Premium", "Elite", "Gold"]
    var takeAwatTime = ["15 Mins", "30 Mins", "45 Mins", "1 Hour"]
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
                            
                            CartAddItemCell(itemNames: item.foodName, itemPrice: (Float(item.foodPrice ?? "0.00") ?? 0.00), itemQuantity: (Int(item.foodQuantity ?? "0") ?? 0),itemId: item.foodId, getDataValue:({
                              //  dbViewModel.getAllDataFromTable()
                             //   getTotalAmount = calculatingTotalPrice()
                            }))
                                .background(Color("ColorAppGrey"))
                                .frame(height: 70)
                                .cornerRadius(5)
                                .background(Color.black)
                        }
                    }.listStyle(GroupedListStyle())
                        .frame(height: geometry.size.height/2)
                }
                }
                       // .frame( height: geometry.size.height)
                       // .background(Color.black)
                    VStack{
                        ScrollView{
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
                        Divider()
                            .frame(height: 2)
                            .background(Color.white.opacity(0.7))
                            .padding([.bottom],20)
                    }
                    .background(Color.black)
                    if deliveryCLicked{
                        VStack{
                           
                            CartItemContentView(tittleText: "Date Of Order", buttonName: Date().currentDateOnly, imageName: "calendar" ,getDataValue: {
                                clickBookingDate = true
                               
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Theatre Name", buttonName: theaterNames[0], imageName: "chevron.down", dropDownDatas : theaterNames,getDataValue: {
                                
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Screen Name", buttonName: screenNames[0], imageName: "chevron.down", dropDownDatas : screenNames,getDataValue: {
                                
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Show", buttonName: showTimes[0], imageName: "chevron.down", dropDownDatas : showTimes,getDataValue: {
                                
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Seat Area", buttonName: seatArea[0], imageName: "chevron.down" , dropDownDatas : seatArea ,getDataValue: {
                                
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Seat Area", buttonName: "Elite", imageName: "chevron.down",getDataValue: {
                                
                            })
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
                            
                            CartItemContentView(tittleText: "Date Of Order", buttonName: Date().currentDateOnly, imageName: "calendar" ,getDataValue: {
                                clickBookingDate = true
                            })
                                .frame(width: geometry.size.width, height: 70)
                            CartItemContentView(tittleText: "Select Takeaway Time", buttonName: takeAwatTime[0], imageName: "chevron.down" , dropDownDatas : takeAwatTime,getDataValue: {
                                
                            })
                                .frame(width: geometry.size.width, height: 70)
                        }
                        VStack(spacing : 5){
                            HStack{
                              Text("Item Total")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Spacer()
                                Text("$ \(storeDataViewModel.calculateTotalPrice())")
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
                        Text("₹ \(storeDataViewModel.calculateTotalPrice())")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                        
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
                storeDataViewModel.
//               / dbViewModel.getAllDataFromTable()
               // getTotalAmount = calculatingTotalPrice()
            }
        }
    }
//    func calculatingTotalPrice() -> String{
//      //  getAllDataFromTable()
//        var price : Float = 0
//        dbViewModel.getCartDataValues.forEach { item in
//            price += ((Float(item.price ?? "") ?? 0.00) * (Float(item.quantity ?? "") ?? 0.00) )
//        }
//      //  totalAmounts = String(format: "%.2f", price)
//        return String(format: "%.2f", price)
//    }
}

struct CartPageView_Previews: PreviewProvider {
    static var previews: some View {
        CartPageView()
            .background(Color.black)
    }
}
