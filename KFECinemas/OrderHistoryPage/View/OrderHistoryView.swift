//
//  OrderHistoryView.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import SwiftUI

struct OrderHistoryView: View {
    var orderItemNames : String = ""
    @State var clickingButton : String = "Ticket"
   
    @ObservedObject var viewModel = OrderHistoryViewModel()
    var body: some View {
        GeometryReader { geometry in
        ZStack{
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
                    .padding(3)
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
                .padding(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 20))
                .frame(minWidth: geometry.size.width,maxHeight: 60)
                .background(Color.black)
                if clickingButton == "Ticket"{
                    List(viewModel.getTicketHistoryData?.data ?? [] , id : \.self){ value in
                        Text(value.movieDetails?.movieName ?? "")
                    }
                }else if clickingButton == "Spice Kitchen"{
                    if viewModel.getSpiceKitcehnData?.data?.count != 0{
                       
                        List(viewModel.getSpiceKitcehnData?.data ?? [] , id : \.self){ value in
                            ForEach(value , id : \.self){ finalValues in
                                Text(finalValues.itemName ?? "")
                            }
                        }
//                        ForEach(viewModel.getSpiceKitcehnData?.data ?? [] , id : \.self){ value in
//                            List(value , id : \.self){ finalValues in
//                                Text(finalValues.itemName ?? "")
//                            }
//                        }
                    }
                  
                }else{
                    if viewModel.getConcessionZoneData?.data?.count != 0{
                       
                        List(viewModel.getConcessionZoneData?.data ?? [] , id : \.self){ value in
                          //  var orderItemValue = ""
                            ForEach(value , id : \.self){ finalValues in
                                
                              //  orderItemNames = "\(finalValues.quantity ?? "") X \(finalValues.itemName ?? "")"
                
                              //  orderItemValue = ""
                                Text(finalValues.itemName ?? "")
                            }
                        }
                    }
                }
               
                
            }
            .onAppear(){
                viewModel.getTicketHistoryApi()
                viewModel.getConcessionZoneApi()
                viewModel.getSpiceKitchenHistoryApi()
            }
        }
    }
    }
}

struct OrderHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderHistoryView()
    }
}
