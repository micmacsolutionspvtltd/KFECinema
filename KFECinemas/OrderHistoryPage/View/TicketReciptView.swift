//
//  TicketReciptView.swift
//  KFECinemas
//
//  Created by MAC on 04/05/22.
//

import SwiftUI

struct TicketReciptView: View {
   @State var reciptDatas: MovieDetails?
    @State var lastPage : String?
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var movieName :String?
    @State var showDate : String?
    @State var showTime : String?
    @State var ticketFormat : String?
    @State var theatreName : String?
    @State var screenName : String?
    @State var seatNumber : String?
    @State var bookingId : String?
    @State var snacksName : String?
    @State var ticketPrice : String?
    @State var snacksprice : String?
    @State var deliverPrice : String?
    @State var totalPrice : String?
    @State var moveToDashBoard : Bool = false
    @Environment(\.rootPresentationMode)  var rootPresentationMode: Binding<RootPresentationMode>
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(showsIndicators:false){
            ZStack{
               
           //     GeometryReader{ innerGeometry in
                VStack(alignment : .leading,spacing: 50){
                    ZStack{
                        Text("Ticket Recipt")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                            HStack(alignment: .bottom ){
                               // NavigationLink{
                                Button{
                                  //  Dashboard()
                                    if lastPage == "checkout"{
                                        self.rootPresentationMode.wrappedValue.dismiss()
                                    }else{
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                     
                                }label: {
                                    
                                    
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25.0, height: 25.0)
                                        
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                    VStack{
                    HStack{
                        Image("pro")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                        Text(movieName ?? "")
                        .fontWeight(.bold).multilineTextAlignment(.leading)
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
                            }.frame(minWidth: geometry.size.width/1.2)
                            HStack{
                                Text(showDate ?? "")
                                    .multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text(showTime ?? "")
                                     
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text("")
                                     
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
                                Text("Screen")
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
                                Text(theatreName ?? "")
                                    .multilineTextAlignment(.leading)
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true)
                                Text(screenName ?? "")
                                     
                                     
                                     .frame(maxWidth: .infinity)
                                     .fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.leading)
                                Text(seatNumber ?? "")
                                     
                                     .frame(maxWidth: .infinity)
                                     .multilineTextAlignment(.leading)
                                     .fixedSize(horizontal: false, vertical: true)
                            }.frame(minWidth: geometry.size.width*0,idealWidth: 7)
                        }
                        HStack{
                            VStack(spacing : 5){
                                Text("Order Id")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                Text(bookingId ?? "")
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            Text("Booking Confirmed")
                                .font(.system(size: 13)).padding(EdgeInsets(top: 8, leading: 5, bottom: 8, trailing: 5)).background(Color.red).cornerRadius(5).foregroundColor(.white)
                        }
                    }
                    Divider()
                        .frame( height:1)
                        .background(Color.white)
                        if snacksName != "" && snacksName != " x "{
                    VStack(alignment : .leading,spacing : 5){
                        HStack{
                            VStack(spacing : 5){
                                Text("Snacks")
                                    .foregroundColor(.gray).multilineTextAlignment(.leading)
                                Text(snacksName ?? "")
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                        }
                        Divider()
                            
                            .frame( height:1)
                            
                            .background(Color.white)
                    }
                        }
                    VStack(spacing : 7){
                        HStack{
                            Text("Ticket Price")
                                .font(.system(size: 15)).multilineTextAlignment(.leading)
                            Spacer()
                            Text(ticketPrice ?? "")
                                .multilineTextAlignment(.trailing)
                        }
                        if snacksName != "" && snacksName != " x "{
                            HStack{
                                Text("Snacks and Beverage Price")
                                    .font(.system(size: 15)).multilineTextAlignment(.leading)
                                Spacer()
                                Text("\(snacksprice ?? "")")
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        if deliverPrice != ""{
                            HStack{
                                Text("Deliver Price")
                                    .font(.system(size: 15)).multilineTextAlignment(.leading)
                                Spacer()
                                Text("\(deliverPrice ?? "")")
                                    .multilineTextAlignment(.trailing)
                            }
                        }
                        Divider()
                            
                            .frame( height:1)
                        
                            .background(Color.white)
                    
                        HStack{
                            Text("Total")
                                .font(.system(size: 18)).multilineTextAlignment(.leading)
                            Spacer()
                            Text("\(totalPrice ?? "")")
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
                    VStack{
                        HStack{
                            Spacer()
                            Text("Check your email \(StorageSettings().emailAddress)")
                                .font(.system(size: 15))
                            Spacer()
                        }
                       
                    }.padding(.bottom , 15)
                }
                   
              //  }
            }.foregroundColor(.black)
            }.padding().background(Color.white)  .cornerRadius(10).padding()
              
                .navigationBarHidden(true)
                .onAppear(){
                    if lastPage != "checkout"{
                   
                        movieName = reciptDatas?.movieName
                        movieName = reciptDatas?.movieName
                        showDate = reciptDatas?.bookingDate
                        showTime = reciptDatas?.showTime
                        
                        theatreName = reciptDatas?.theatreName
                        screenName = reciptDatas?.screenName
                        seatNumber = ("\(reciptDatas?.zoneInScreen ?? "") - \(reciptDatas?.seatNo ?? "")")
                        bookingId = reciptDatas?.bookingID ?? ""
                       
                        ticketPrice = reciptDatas?.movieAmount ?? ""
                       // snacksprice = reciptDatas?.snacksDeliveryAmt ?? ""
                        deliverPrice = reciptDatas?.snacksDeliveryAmt ?? ""
                        totalPrice = reciptDatas?.totalAmount ?? ""
                    }
                   
                }
//            NavigationLink(destination: Dashboard(), isActive: $moveToDashBoard){
//
//            }
        }.background(LinearGradient(gradient: SwiftUI.Gradient(colors: [Constants.CustomColors.sideMenuColor1,Constants.CustomColors.sideMenuColor2]), startPoint: .top, endPoint: .bottom))
  
        
    }
}

struct TicketReciptView_Previews: PreviewProvider {
    static var previews: some View {
        TicketReciptView()
    }
}
