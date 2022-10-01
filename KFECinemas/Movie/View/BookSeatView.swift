//
//  BookSeatView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 10/05/22.
//

import SwiftUI

struct BookSeatView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 
  
    @EnvironmentObject var movieServices:MovieServices
    var model:BookSeatModel
    var seatList = [SeatStatusModel(imageName: "white_seat", status: "Available"),SeatStatusModel(imageName: "red_seat", status: "Booked"),SeatStatusModel(imageName: "green_seat", status: "Selected")]
    @State private var isActive : Bool = false

   @State var daysOfWeek:[Date] = []
    @State var showingAlert = false
    @State var showLoader : Bool = false
    @State var showToast : Bool? = false
    @State var errorMsg = "This seat already selected please choose another seat"
    @State var showSeatAreaChangePopup : Bool? = false
    @State var termsAndConditionPopup = false
    var body: some View {
        GeometryReader { geometry in
        ScrollView(showsIndicators:false){
            VStack {
                VStack {
                    HStack(alignment: .center) {
                        Button(action:{
                            if movieServices.storeSelectedSeats.count == 0{
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
                                Text("\(layout.strAreaDesc ?? "") - ₹ \(layout.amount ?? 0)")
                                SeatClassView(seatLayout: layout , showLoader: $showLoader, showToast : $showToast, showPopup: $showSeatAreaChangePopup, errorMsg: $errorMsg)
                            }
                          
                        }
                    }
                }
                
                Spacer().frame(height : 50)
                Text("Screen This way")
                Image("screen_image")
                    .resizable().frame(width: geometry.size.width, height: 50)
                
            }.foregroundColor(.white)
        }.loaderView(isShowing: $showLoader)
                .toast(isShowing: $showToast,textContent: errorMsg , backGroundColor : Color.white)

        .alert(isPresented: $showingAlert){
            Alert(
                title: Text("CONFIRMATION"),
                message: Text("Do you want to end the session"),
                primaryButton: .default(Text("Yes"), action: {
                    resetSeatMultipleSeats(goBack: "")
                    self.presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .cancel(Text("Cancel"), action: { // 1
                    showingAlert = false
                    
                })
            )
        }.edgesIgnoringSafeArea(.all).navigationBarHidden(true).onAppear(perform: {
            movieServices.storeSelectedSeats = []
            movieServices.selectedSeatId = []
            print(model.show.addionalData)
            showLoader = true
            termsAndConditionPopup = true
            movieServices.selectedScreen = model
            let requestModel = ["cinema_code":model.show.cinemaStrID ?? "","session_code":"\(model.show.sessionLngSessionID ?? 0 )"]
            movieServices.getSeatLayout(requestBody: requestModel, completionHandler: { result in
                showLoader = false
            })
            
            let date = Common.sharedInstance.getDateFormatFromDateString(dateString: model.show.sessionDtmFilmFirstShow ?? "" )
        
            let time = Common.sharedInstance.getShowTime(time: model.show.showTime ?? "" )
            let finalScreenName : String
            if model.show.screenStrName?.contains("-") == false{
                var screenName = model.show.screenStrName ?? ""
                let lastValue = screenName.removeLast()
               finalScreenName = (screenName + "-\(lastValue)")
            }else{
                finalScreenName = model.show.screenStrName ?? ""
            }
           
            let checkoutDetails = CheckoutModel(movieName: model.movieName, theatreName: model.theatreName, screenName: finalScreenName, date: date, showTime: time, seatRow: "", seatNo: "", ticketPrice: "", totalPrice: "")
            movieServices.checkoutDetails = checkoutDetails
        }).background(Color("ColorAppGrey"))
                .background( NavigationLink("", isActive: $isActive) {
                    // LoginView()
                    if model.theatreName == "Spice  Cinemas"{
                                          SpiceKitchenView(pageName : "Concession Zone" , lastPage: "bookSeatView",theaterID : "0002",theaterName : model.theatreName)
                                      }else{
                                          SpiceKitchenView(pageName : "Concession Zone" , lastPage: "bookSeatView",theaterID : "0003", theaterName : model.theatreName)
                                      }
                 }
                .hidden())
                        if showSeatAreaChangePopup ?? false{
                            GeometryReader{_ in
                            SeatAreaChangePopupView(hidePopup: $showSeatAreaChangePopup) {
                                resetSeatMultipleSeats(goBack: "No")
                               
                                showSeatAreaChangePopup = false
                                showLoader = false
                            }  .frame(width: 300, height: 220)
                                .padding()
                                 .cornerRadius(8)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                            }
                                .background(Color.black.opacity(0.6)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                        withAnimation {
                                            showSeatAreaChangePopup = false
                                        }
                                    })
                            
                        }
       
            if movieServices.storeSelectedSeats.count == 0{

            }else{
              //  NavigationLink( isActive : self.$isActive){
                
                Button{
                    print(movieServices.calculateSeats())
                    print(movieServices.calculateTotalPrice())
                    showLoader = true
                    let requestBody = ["CinemaCode" : getSetSeatRequest().0 , "lngSessionId" : getSetSeatRequest().1 , "strTicketType" : getSetSeatRequest().2 , "SelectedSeats" : getSetSeatRequest().3 ,"intQty" : getSetSeatRequest().4, "StrTransID" : movieServices.storeSelectedSeats[0].strTransID]
                    movieServices.setSeats(requestBody: requestBody) { result in
                        if result.responseCode == 0{
                            showToast = true
                            errorMsg = result.responseMessage ?? ""
                        }else{
                        print("Sucess")
                        movieServices.checkoutDetails?.ticketPrice = movieServices.storeSelectedSeats[0].amount
                        movieServices.checkoutDetails?.totalPrice = movieServices.calculateTotalPrice()
                        let seatValue = FinalSeatModel(strSeatInfo: result.data?.strSeatInfo ?? "", intBookID: result.data?.intBookID ?? 0, strTransID: result.data?.strTransID ?? "", strBookId: "")
                        movieServices.selectedSeatId.append(seatValue)
                        showLoader = false
                        isActive = true
                        }
                    }
                } label: {
                    HStack(spacing :20){
                        Text("\(movieServices.storeSelectedSeats[0].seatArea )- \(movieServices.calculateSeats())").fontWeight(.bold)
                        .fontWeight(.bold)
                       // Text("mn")
                            .foregroundColor(.white)
                            .frame(height: 100)
                       Text("₹ \(movieServices.calculateTotalPrice())")
                     //   Text("mn")
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
                }//.isDetailLink(false)
                
                .position(x: geometry.size.width/2, y: geometry.size.height/1.1)
        }
            if termsAndConditionPopup {
              //  GeometryReader{_ in
                TermsAndConditionPopup(showPopup : $termsAndConditionPopup, cancelClick: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        .frame(width: 340, height: UIScreen.main.bounds.height*0.85)
                    .background(Color.white)
                    .background(Color.white)
                    .cornerRadius(8)
                
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
              //  }
                .background(Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                          //  termsAndConditionPopup = false
                        }
                    })
            }
               
    }.toast(isShowing: $showToast,textContent: errorMsg , backGroundColor : Color.white)
            
    }
    func resetSeatMultipleSeats(goBack : String){
        
            let filteredArray = movieServices.selectedSeatId.filter { value in
              //  if value.strTransId != nil{
                movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransID )"])
                    return false
             //   }
          
            }
            movieServices.selectedSeatId = []
        if goBack != ""{
            movieServices.selectedScreen = model
            let requestModel = ["cinema_code":model.show.cinemaStrID ?? "","session_code":"\(model.show.sessionLngSessionID ?? 0 )"]
            movieServices.getSeatLayout(requestBody: requestModel, completionHandler: { result in
                showLoader = false
            })

        }
      
      //  }
       
    }
    func getSetSeatRequest() -> (String , String, String , String , String){
        var movieFormat = ""
//        var nameAndQuantity = ""
//        var foodId = ""
//        var foodQty = ""
     
        for i in movieServices.storeSelectedSeats{
            if movieFormat == ""{
                movieFormat = ("|" + String(movieServices.storeSelectedSeats.count ) + "|" + (i.areaCode) + "|" + i.areaNum + "|" + i.gridSeatRowID + "|" + i.gridSeatNumber +
                               "|" )
            }else{
                movieFormat += ((i.areaCode) + "|" + i.areaNum + "|" + i.gridSeatRowID + "|" + i.gridSeatNumber + "|")
            }
        }
        
//        for i in storeDataViewModel.items{
//            nameAndQuantity += "\(i.foodQuantity ?? "") x \(i.foodName ?? ""),"
//            if foodId == ""{
//                foodId = ("|" + String(storeDataViewModel.items.count) + "|" + (i.foodId ?? "") + "|")
//                foodQty = ((i.foodQuantity ?? "") + "|-1|")
//
//            }else{
//                foodId = ((i.foodId ?? "") + "|")
//                foodQty = ((i.foodQuantity ?? "") + "|-1|")
//            }
//            finalId += foodId + foodQty
//            nameAndQuantity = String(nameAndQuantity.dropLast())
//        }
        
        
        return ( movieServices.selectedScreen?.show.cinemaStrID ?? "" ,"\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )" , movieServices.storeSelectedSeats[0].strTypeCode , movieFormat , String(movieServices.storeSelectedSeats.count ))
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
    @Binding var showLoader : Bool
    @Binding var showToast : Bool?
    @Binding var showPopup : Bool?
    @Binding var errorMsg : String
    var body: some View {
        VStack {
            ForEach(seatLayout.rows ?? [],id: \.self){ row in
                HStack{
                    Text(row.strRowPhyID ?? "")
                    SeatRowView(seatRow:row,seatLayout: seatLayout , showLoader: $showLoader, showToast : $showToast, showPopup: $showPopup, errorMsg: $errorMsg)
                }
            }
        }
    }
}

struct SeatRowView:View {
    var seatRow:Row
    var seatLayout:SeatLayout
    @Binding var showLoader : Bool
    @Binding var showToast : Bool?
    @Binding var showPopup : Bool?
    @Binding var errorMsg : String
    var body: some View {
        ForEach(seatRow.seats ?? [],id: \.self){ seat in
            SeatView(seat:seat,seatRow: seatRow,seatLayout: seatLayout, showLoader: $showLoader, showToast : $showToast, showPopup: $showPopup, errorMsg: $errorMsg)
        }
    }
}

struct SeatView:View {
    var seat:Seat
    var seatRow:Row
    var seatLayout:SeatLayout
   
   
   @State var isSelected = false
    @Binding var showLoader : Bool
    @Binding var showToast : Bool?
    @Binding var showPopup : Bool?
    @Binding var errorMsg : String
    @EnvironmentObject var movieServices:MovieServices
    var body: some View {
        HStack{
            if seat.strSeatStatus == "-1" {
                Text("").frame(width: 25, height: 25)
            }else if seat.strSeatStatus ==  "0"{
                if isSelected == true{
                    Image("green_seat") .resizable()
                        .frame(width: 25, height: 25)
                }else{
                    Image("white_seat") .resizable()
                        .frame(width: 25, height: 25)
                }
                
                
            }else {
                Image("red_seat") .resizable()
                    .frame(width: 25, height: 25)
            }
        }.onTapGesture {
            if seat.strSeatStatus == "0"{
                isSelected = !isSelected
                showLoader = true
                if isSelected{
                    
                    if setSeatConfirm(strTicketType :  seatLayout.strAreaDesc ?? ""){
                        var requestBody : SetSeatRequestModel
                        if movieServices.selectedSeats.count != 10{
                            if movieServices.selectedScreen?.show.cinemaStrID == "0002" && movieServices.selectedScreen?.show.addionalData != nil{
                                requestBody = SetSeatRequestModel(strTypeCode: movieServices.selectedScreen?.show.strTicketType ?? "", cinemaCode: movieServices.selectedScreen?.show.cinemaStrID ?? "", strTransID: movieServices.seatLayouts?.strTransID ?? "", lngSessionID: "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )", strTicketType: movieServices.selectedScreen?.show.strTicketType ?? "", gridSeatRowID: seatRow.intGridRowID?.description ?? "", gridSeatNumber: seat.intGridSeatNum?.description ?? "",rowId: seatRow.strRowPhyID ?? "",areaCode: seatLayout.strAreaCode ?? "" , areaNum: seatLayout.strAreaNum ?? "" , amount: String(seatLayout.amount ?? 0) ,seatArea : seatLayout.strAreaDesc ?? "", srtSeatNumber : seat.strSeatNumber?.description ?? "")
                            }else if movieServices.selectedScreen?.show.cinemaStrID == "0003" && movieServices.selectedScreen?.show.addionalData != nil && seatLayout.strAreaNum == "1"{
                                requestBody = SetSeatRequestModel(strTypeCode: movieServices.selectedScreen?.show.strTicketType ?? "", cinemaCode: movieServices.selectedScreen?.show.cinemaStrID ?? "", strTransID: movieServices.seatLayouts?.strTransID ?? "", lngSessionID: "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )", strTicketType: movieServices.selectedScreen?.show.strTicketType ?? "", gridSeatRowID: seatRow.intGridRowID?.description ?? "", gridSeatNumber: seat.intGridSeatNum?.description ?? "",rowId: seatRow.strRowPhyID ?? "",areaCode: seatLayout.strAreaCode ?? "" , areaNum: seatLayout.strAreaNum ?? "" , amount: String(seatLayout.amount ?? 0) ,seatArea : seatLayout.strAreaDesc ?? "", srtSeatNumber : seat.strSeatNumber?.description ?? "")
                            }else if movieServices.selectedScreen?.show.cinemaStrID == "0003" && movieServices.selectedScreen?.show.addionalData != nil && seatLayout.strAreaNum == "2"{
                                requestBody = SetSeatRequestModel(strTypeCode: movieServices.cinemaStridTwo ?? "", cinemaCode: movieServices.selectedScreen?.show.cinemaStrID ?? "", strTransID: movieServices.seatLayouts?.strTransID ?? "", lngSessionID: "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )", strTicketType: movieServices.cinemaStridTwo ?? "", gridSeatRowID: seatRow.intGridRowID?.description ?? "", gridSeatNumber: seat.intGridSeatNum?.description ?? "",rowId: seatRow.strRowPhyID ?? "",areaCode: seatLayout.strAreaCode ?? "" , areaNum: seatLayout.strAreaNum ?? "" , amount: String(seatLayout.amount ?? 0) ,seatArea : seatLayout.strAreaDesc ?? "", srtSeatNumber : seat.strSeatNumber?.description ?? "")
                            }else{
                                requestBody = SetSeatRequestModel(strTypeCode: seatLayout.strTicketType ?? "", cinemaCode: movieServices.selectedScreen?.show.cinemaStrID ?? "", strTransID: movieServices.seatLayouts?.strTransID ?? "", lngSessionID: "\(movieServices.selectedScreen?.show.sessionLngSessionID ?? 0 )", strTicketType: seatLayout.strTicketType ?? "", gridSeatRowID: seatRow.intGridRowID?.description ?? "", gridSeatNumber: seat.intGridSeatNum?.description ?? "",rowId: seatRow.strRowPhyID ?? "",areaCode: seatLayout.strAreaCode ?? "" , areaNum: seatLayout.strAreaNum ?? "" , amount: String(seatLayout.amount ?? 0) ,seatArea : seatLayout.strAreaDesc ?? "" , srtSeatNumber : seat.strSeatNumber?.description ?? "")
                            }
                            movieServices.storeSelectedSeats.append(requestBody)
                            print(movieServices.storeSelectedSeats)
                            showLoader = false
//                        movieServices.setSeats(seat: seat,layout: seatLayout,requestBody: requestBody.getJson()) { result in
//                            showLoader = false
//                            if result.responseCode == 0{
//    //                            errorMsg = result.responseMessage ?? ""
//    //                            errorPopShow = true
//                                errorMsg = result.responseMessage ?? ""
//                                showToast = true
//                                isSelected = false
//                            }else{
//                               isSelected = true
//                            }
//                        }
                        }else{
                            showLoader = false
                            errorMsg = "You cannot select more than 10 seats."
                            showToast = true
                            isSelected = false
                        }
                    }else{
                        isSelected = false
                        showLoader = false
                        showPopup =  true
                    }
                 }else{
                showLoader = true
                    let filteredArray = movieServices.storeSelectedSeats.filter { value in
                        if(value.gridSeatNumber == (seat.intGridSeatNum?.description ?? "") && value.rowId == seatRow.strRowPhyID){
                          
//                            movieServices.resetSeats(requestBody: ["CinemaCode":movieServices.selectedScreen?.show.cinemaStrID ?? "","StrTransId":"\(value.strTransId ?? "")"])
                            isSelected = false
                            showLoader = false
                              return false
                        }else{
                            showLoader = false
                            return true
                        }
                    }
                     showLoader = false
                    movieServices.storeSelectedSeats = filteredArray
                     print(movieServices.storeSelectedSeats)
                }
                
                print(movieServices.selectedSeats)
            }
            
       
        }
      //  .toast(isShowing: $errorPopShow,textContent: errorMsg)
    }
    
    func setSeatConfirm(strTicketType :  String) -> Bool{
        if movieServices.storeSelectedSeats.count != 0{
            if movieServices.storeSelectedSeats[0].seatArea == strTicketType{
                return true
            }else{
                return false
            }
        }else{
            return true
        }
      
    }
    
}

//struct BookSeatView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookSeatView()
//    }
//}
