//
//  BookSeatView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 10/05/22.
//

import SwiftUI

struct BookSeatView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var movieServices:MovieServices
    var model:BookSeatModel
    var seatList = [SeatStatusModel(imageName: "white_seat", status: "Available"),SeatStatusModel(imageName: "grey_seat", status: "Booked"),SeatStatusModel(imageName: "red_seat", status: "Selected")]

   @State var daysOfWeek:[Date] = []
    @State var showingAlert = false
    var body: some View {
        GeometryReader { geometry in
        ScrollView(showsIndicators:false){
            VStack {
                VStack {
                    HStack(alignment: .center) {
                        Button(action:{
                            if movieServices.selectedSeats.count == 0{
                                self.presentationMode.wrappedValue.dismiss()
                            }else{
                           showingAlert = true
                            }
                        }){
                            
                            Image(systemName:  "arrow.left").foregroundColor(.white).padding()
                        }
                        Spacer()
                        Text(model.movieName).font(.system(size: 22)).fontWeight(.bold)
                        Spacer()
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 5, trailing: 10))
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text(model.theatreName).font(.system(size: 20)).fontWeight(.bold)
                            Text(model.show.screenStrName ?? "")
                        }.padding()
                        Spacer()
                        VStack {
                            Text( Common.sharedInstance.getDateFormatFromDateString(dateString: model.show.sessionDtmFilmFirstShow ?? "" )).foregroundColor(.white)
                            Text( Common.sharedInstance.getShowTime(time: model.show.showTime ?? "" )).foregroundColor(.white).fontWeight(.bold).frame(alignment:.center).padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)).overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 4)
                            )
                        }.padding()
                        Spacer()
                    }
                }.background(Color.red)
               
                HStack{
                    ForEach(seatList,id:\.id){ seat in
                        SeatStatusView(seatStatus: seat).frame(maxWidth:.infinity)
                    }
                }
                ScrollView(.horizontal,showsIndicators: false){
                    VStack{
                        ForEach(movieServices.seatLayouts?.data ?? [] , id : \.id){ layout in
                            VStack{
                                Text(layout.strAreaDesc ?? "")
                                SeatClassView(seatLayout: layout)
                            }
                          
                        }
                    }
                }
                
               
                
            }.foregroundColor(.white)
        } .alert(isPresented: $showingAlert){
            Alert(
                title: Text("CONFIRMATION"),
                message: Text("Do you want to end the session"),
                primaryButton: .default(Text("Yes"), action: {
                    resetSeatMultipleSeats()
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel(Text("Cancel"), action: { // 1
                    showingAlert = false
                    
                })
            )
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true).onAppear(perform: {
            movieServices.selectedScreen = model
            let requestModel = ["cinema_code":model.show.cinemaStrID ?? "","session_code":"\(model.show.sessionLngSessionID ?? 0 )"]
            movieServices.getSeatLayout(requestBody: requestModel)
            
            let date = Common.sharedInstance.getDateFormatFromDateString(dateString: model.show.sessionDtmFilmFirstShow ?? "" )
            let time = Common.sharedInstance.getShowTime(time: model.show.showTime ?? "" )
            let checkoutDetails = CheckoutModel(movieName: model.movieName, theatreName: model.theatreName, screenName: model.show.screenStrName ?? "", date: date, showTime: time, seatRow: "", seatNo: "", ticketPrice: "", totalPrice: "")
            movieServices.checkoutDetails = checkoutDetails
        }).background(Color("ColorAppGrey"))
            if movieServices.selectedSeats.count == 0{

            }else{
                NavigationLink{
                    SpiceKitchenView(pageName : "Concession Zone" , lastPage: "bookSeatView")
                } label: {
                    HStack(spacing :20){
                        Text("\(movieServices.calculateSeats())")
                        //.fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(height: 100)
                        Text("₹ \(movieServices.calculateTotalPrice())")
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                            .frame(height: 100)
                            Spacer()
                        Text("BOOK")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                            .frame(width: 60, height: 10)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(.infinity)
//
                        
                   }
                    .frame(maxWidth: .infinity)
                    .frame(height : 25)
                //    .frame(width: geometry.size.width*0.8, height: 35, alignment: .center)
                 //   .padding(EdgeInsets(top: 10, left: -15, bottom: 10, right: -15))
                    .padding(.vertical , 15)
                    .padding(.horizontal,5)
                    
                    .background(Color.red)
                    .cornerRadius(8)
                }
                .position(x: geometry.size.width/2, y: geometry.size.height/1.1)
        }
               
    }
    }
    func resetSeatMultipleSeats(){
        
            let filteredArray = movieServices.selectedSeats.filter { value in
              //  if value.strTransId != nil{
                    movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
                    return false
             //   }
          
            }
            movieServices.selectedSeats = []
      //  }
       
    }
}


struct SeatStatusView:View {
    var seatStatus:SeatStatusModel
    var body: some View {
        VStack(spacing:10) {
            
            Image(seatStatus.imageName)
                .resizable()
                .frame(width: 35, height: 35)
            Text(seatStatus.status)
                .font(.system(size: 12))

        }
    }
}

struct SeatClassView:View {
    var seatLayout:SeatLayout
    var body: some View {
        VStack {
            ForEach(seatLayout.rows ?? [],id: \.self){ row in
                HStack{
                    Text(row.strRowPhyID ?? "")
                    SeatRowView(seatRow:row,seatLayout: seatLayout)
                }
            }
        }
    }
}

struct SeatRowView:View {
    var seatRow:Row
    var seatLayout:SeatLayout
    var body: some View {
        ForEach(seatRow.seats ?? [],id: \.self){ seat in
            SeatView(seat:seat,seatRow: seatRow,seatLayout: seatLayout, errorMsg: "")
        }
    }
}

struct SeatView:View {
    var seat:Seat
    var seatRow:Row
    var seatLayout:SeatLayout
    @State var errorPopShow : Bool?
    @State var errorMsg : String
   
   @State var isSelected = false
    @EnvironmentObject var movieServices:MovieServices
    var body: some View {
        HStack{
            if seat.strSeatStatus == "-1" {
                Text("").frame(width: 25, height: 25)
            }else if seat.strSeatStatus ==  "0"{
                if isSelected == true{
                    Image("red_seat") .resizable()
                        .frame(width: 25, height: 25)
                }else{
                    Image("white_seat") .resizable()
                        .frame(width: 25, height: 25)
                }
                
                
            }else {
                Image("grey_seat") .resizable()
                    .frame(width: 25, height: 25)
            }
        }.onTapGesture {
            if seat.strSeatStatus == "0"{
                isSelected = !isSelected
                if isSelected{
                    
                    let requestBody = SetSeatRequestModel(strTypeCode: movieServices.selectedScreen?.show.strTicketType ?? "", cinemaCode: movieServices.selectedScreen?.show.cinemaStrID ?? "", strTransID: movieServices.seatLayouts?.strTransID ?? "", lngSessionID: "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )", strTicketType: movieServices.selectedScreen?.show.strTicketType ?? "", gridSeatRowID: seatRow.intGridRowID?.description ?? "", gridSeatNumber: seat.intGridSeatNum?.description ?? "",rowId: seatRow.strRowPhyID ?? "")
                    movieServices.setSeats(seat: seat,layout: seatLayout,requestBody: requestBody.getJson()) { result in
                        if result.responseCode == 0{
//                            errorMsg = result.responseMessage ?? ""
//                            errorPopShow = true
                            isSelected = false
                        }else{
                           isSelected = true
                        }
                    }
                    
                }else{
                
                    let filteredArray = movieServices.selectedSeats.filter { value in
                        if(value.key == seat.key){
                          
                            movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
                              return false
                        }else{
                            return true
                        }
                    }

                    movieServices.selectedSeats = filteredArray
                }
                
                print(movieServices.selectedSeats)
            }
            
       
        }
      //  .toast(isShowing: $errorPopShow,textContent: errorMsg)
    }
    
}

//struct BookSeatView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookSeatView()
//    }
//}
