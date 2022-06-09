//
//  OrderHistoryView.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import SwiftUI

struct OrderHistoryView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

    var orderItemNames : String = ""
    @State var clickingButton : String = "Ticket"
   
    @ObservedObject var viewModel = OrderHistoryViewModel()
   @State var name : String = ""
    @State private var linkActive = false
   @State var selectedRowNumber  = 0
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    var body: some View {
        GeometryReader { geometry in
        ZStack{
            Constants.CustomColors.colorAppGrey
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack{
                    Text("Booking History")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .accentColor(Color.white)
                    HStack{
                        HStack(alignment: .bottom ){
                          //  NavigationLink{
                                Button{
                             //   Dashboard()
                                   
                                  presentationMode.wrappedValue.dismiss()
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
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
                .frame(minWidth: geometry.size.width,maxHeight: 60)
                .background(Color.red)
                HStack{
                    Button{
                        clickingButton = "Ticket"
                    }label: {
                       Text("Ticket")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                           
                    }
                    .frame(height: 56)
                    .background(clickingButton == "Ticket" ? Color.red : Color.black)
                   // .padding(3)
                    .cornerRadius(10)
                    Button{
                        clickingButton = "Concession Zone"
                    }label: {
                       Text("Concession Zone")
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: false, vertical: true)
                           
                    }
                    .frame(height: 56)
                    .background(clickingButton == "Concession Zone" ? Color.red : Color.black)
                   
                    .cornerRadius(10)
                    Button{
                        clickingButton = "Spice Kitchen"
                    }label: {
                       Text("Spice Kitchen")
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .frame(maxWidth: .infinity)
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    .frame(height: 56)
                    .background(clickingButton == "Spice Kitchen" ? Color.red : Color.black)
                    .cornerRadius(10)
                }
                .padding(EdgeInsets(top: 15, leading: 3, bottom: 15, trailing: 3))
                .frame(maxWidth: geometry.size.width-10,maxHeight: 60)
                .background(Color.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                )
                ZStack{
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                if clickingButton == "Ticket"{
               //     List(viewModel.getTicketHistoryData?.data ?? [] , id : \.self){ value in
                        List(0..<(viewModel.getTicketHistoryData?.data?.count ?? 0), id : \.self){ (finalValues) in
//                       )
                            Button(action: { self.selectedRowNumber = finalValues
                                linkActive = true
                                
                            }){
                                OrderHisroryViewCell(movieName: viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.movieName ?? "", theaterName: viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.theatreName ?? "", amount: ( "₹ " + (viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.totalAmount ?? "") ), date:  ( "\(Common.sharedInstance.changeFormatMonthAndYear(item:  viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.bookingDate ?? "" , alreadyInType: Constants.DateFormat.dateFormatReverse , needType: Constants.DateFormat.normalDateFormat)) - \(viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.showTime ?? "")"), image : "ticket", bookingId: ("Booking ID : " + (viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.orderConfirmId ?? "") ), bookingSeat: ("Seats: \(viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.zoneInScreen ?? "")- \(viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.seatNo ?? "")"), snacksItems: viewModel.getTicketSnacksData[finalValues] , screenName : (viewModel.getTicketHistoryData?.data?[finalValues].movieDetails?.screenName ?? ""))
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black)
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1))
                               
                            }//.listRowBackground(.black)
                           // .listRowBackground(Color.white)
                            .overlay(VStack {
                                if linkActive {
                                    NavigationLink(destination:  TicketReciptView(reciptDatas : viewModel.getTicketHistoryData?.data?[selectedRowNumber ].movieDetails , snacksName : viewModel.getTicketSnacksData[selectedRowNumber] , snacksprice: viewModel.getTicketSnacksPrice[selectedRowNumber]), isActive: $linkActive) {
                                        
//                                        (viewModel.getTicketHistoryData?.data?[finalValues] ?? [])
                                    }.opacity(0)
                                        .background(Color.red)
                                    
                                }
                            })
                    }
                        .listStyle(PlainListStyle())
                    
                }else if clickingButton == "Spice Kitchen"{
                    if viewModel.getSpiceKitcehnData?.data?.count != 0{
                        
                       
                        List(0..<(viewModel.getSpiceKitcehnData?.data?.count ?? 0), id : \.self){ (finalValues) in
                            OrderHisroryViewCell(movieName : "Spice Kitchen" , theaterName: "Order ID \(viewModel.getSpiceKitcehnData?.data?[finalValues][0].foodOrderID ?? "")", amount: viewModel.getSpiceKitcehnData?.data?[finalValues][0].totalPrice ?? "", date: "Ordered on : \(Common.sharedInstance.changeFormatMonthAndYear(item:  viewModel.getSpiceKitcehnData?.data?[finalValues][0].orderDate ?? "" , alreadyInType: Constants.DateFormat.dateFormatReverse , needType: Constants.DateFormat.normalDateFormat))", snacksItems: viewModel.getKitchenSnacksData[finalValues])
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.black)
                                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1))
//                            }
                        }   .listStyle(PlainListStyle())

                    }
                  
                }else{
                    if viewModel.getConcessionZoneData?.data?.count != 0{
                       
                            List(0..<(viewModel.getConcessionZoneData?.data?.count ?? 0), id : \.self){ (finalValues) in
                                OrderHisroryViewCell(movieName : "Concession Zone" , theaterName: "Order ID \(viewModel.getConcessionZoneData?.data?[finalValues][0].orderID ?? "")", amount: viewModel.getConcessionZoneData?.data?[finalValues][0].totalPrice ?? "", date: "Ordered on : \(Common.sharedInstance.changeFormatMonthAndYear(item:  viewModel.getConcessionZoneData?.data?[finalValues][0].orderDate ?? "" , alreadyInType: Constants.DateFormat.dateFormatReverse , needType: Constants.DateFormat.normalDateFormat))", bookingSeat : "Seats: \(viewModel.getConcessionZoneData?.data?[finalValues][0].seatNo ?? "")", snacksItems: viewModel.getConcessionSnacksData[finalValues])
                            
                                    .frame(maxWidth: .infinity)
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.black)
                                        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 1, y: 1))

                        }   .listStyle(PlainListStyle())
                    }
                }
                }//.listRowBackground(Color.black)
               
                
            }
            .onAppear(){
                viewModel.getTicketHistoryApi()
                viewModel.getConcessionZoneApi()
                viewModel.getSpiceKitchenHistoryApi()
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
            .background(Color.black)
    }
}
