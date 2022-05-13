//
//  TicketReciptView.swift
//  KFECinemas
//
//  Created by MAC on 04/05/22.
//

import SwiftUI

struct TicketReciptView: View {
   @State var reciptDatas: MovieDetails?
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                ScrollView(showsIndicators:false){
                GeometryReader{ innerGeometry in
                VStack(alignment : .leading,spacing: 50){
                    VStack{
                    HStack{
                        Image("pro")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                    Text(reciptDatas?.movieName ?? "")
                        .foregroundColor(.white).fontWeight(.bold).multilineTextAlignment(.leading)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
                    Divider()
                        .frame( height:1)
                        .background(Color.white)
                    VStack(spacing : 20){
                        VStack(alignment : .leading, spacing: 5){
                            HStack{
                                Text("Date")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text("Time")
                                    .foregroundColor(.gray)
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                     .multilineTextAlignment(.leading)
                                Text("Format")
                                        .foregroundColor(.gray)
                                     .frame(maxWidth: .infinity)
                                     .multilineTextAlignment(.leading)
                                     .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: innerGeometry.size.width)
                            HStack{
                                Text(reciptDatas?.bookingDate ?? "")
                                    .foregroundColor(.white).multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text(reciptDatas?.showTime ?? "")
                                     .foregroundColor(.white)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text("Format")
                                     .foregroundColor(.white)
                                     .frame(maxWidth: .infinity)
                                     .multilineTextAlignment(.leading)
                                     .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: geometry.size.width*0,idealWidth: 7)
                        }
                        VStack(alignment : .leading, spacing: 5){
                            HStack{
                                Text("Cinemas")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text("Row")
                                    .foregroundColor(.gray)
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                     .multilineTextAlignment(.leading)
                                Text("Seats")
                                        .foregroundColor(.gray)
                                     .frame(maxWidth: .infinity)
                                     .multilineTextAlignment(.leading)
                                     .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: geometry.size.width*0,idealWidth: 7)
                            HStack{
                                Text(reciptDatas?.theatreName ?? "")
                                    .foregroundColor(.white).multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text(reciptDatas?.screenName ?? "")
                                     .foregroundColor(.white)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text("\(reciptDatas?.zoneInScreen ?? "") - \(reciptDatas?.seatNo ?? "")")
                                     .foregroundColor(.white)
                                     .frame(maxWidth: .infinity)
                                     .multilineTextAlignment(.leading)
                                     .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: geometry.size.width*0,idealWidth: 7)
                        }
                        HStack{
                            VStack(spacing : 5){
                                Text("Order Id")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                Text(reciptDatas?.bookingID ?? "")
                                    .foregroundColor(.white).multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text("Booking Confirmed")
                                .foregroundColor(.white).font(.system(size: 13)).padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5)).background(Color.red).cornerRadius(5)
                        }
                    }
                    Divider()
                        .frame( height:1)
                        .background(Color.white)
                    VStack(alignment : .leading,spacing : 5){
                        HStack{
                            VStack(spacing : 5){
                                Text("Snacks")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                Text("Date")
                                    .foregroundColor(.white).multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        Divider()
                            
                            .frame( height:1)
                            
                            .background(Color.white)
                    }
                    VStack(spacing : 7){
                        HStack{
                            Text("Ticket Price")
                                .foregroundColor(.white).font(.system(size: 15)).multilineTextAlignment(.leading)
                            Spacer()
                            Text(reciptDatas?.movieAmount ?? "")
                                .foregroundColor(.white).multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Snacks and Beverage Price")
                                .foregroundColor(.white).font(.system(size: 15)).multilineTextAlignment(.leading)
                            Spacer()
                            Text(reciptDatas?.snacksOrderedAmt ?? "")
                                .foregroundColor(.white).multilineTextAlignment(.trailing)
                        }
                        HStack{
                            Text("Deliver Price")
                                .foregroundColor(.white).font(.system(size: 15)).multilineTextAlignment(.leading)
                            Spacer()
                            Text(reciptDatas?.snacksDeliveryAmt ?? "")
                                .foregroundColor(.white).multilineTextAlignment(.trailing)
                        }
                        Divider()
                            
                            .frame( height:1)
                            
                            .background(Color.white)
                        HStack{
                            Text("Total")
                                .foregroundColor(.white).font(.system(size: 18)).multilineTextAlignment(.leading)
                            Spacer()
                            Text(reciptDatas?.totalAmount ?? "")
                                .foregroundColor(.white).multilineTextAlignment(.trailing)
                        }
                    }
                }
                    VStack{
                        HStack{
                            Spacer()
                            Text("Check your email \(reciptDatas?.email ?? "")")
                                .foregroundColor(.white).font(.system(size: 15))
                            Spacer()
                        }
                       
                    }
                }
                   
                }
            }.padding().background(Color.black).padding()
            }
            .navigationBarHidden(true)
        }.background(LinearGradient(gradient: SwiftUI.Gradient(colors: [Constants.CustomColors.sideMenuColor1,Constants.CustomColors.sideMenuColor2]), startPoint: .top, endPoint: .bottom))
  
        
    }
}

struct TicketReciptView_Previews: PreviewProvider {
    static var previews: some View {
        TicketReciptView()
    }
}
