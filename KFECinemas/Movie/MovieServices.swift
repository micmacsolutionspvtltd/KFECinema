//
//  MovieServices.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 10/05/22.
//

import Foundation

class MovieServices:ObservableObject {
    
    @Published var shows:[Shows] = []
    @Published var seatLayouts:SeatLayoutResponse?
    @Published var selectedMovie:AllFilms?
    @Published var selectedSeats:[Seat] = []
    @Published var selectedSeatId : [FinalSeatModel] = []
    @Published var selectedScreen:BookSeatModel?
    @Published var checkoutDetails:CheckoutModel?
    @Published var storeSelectedSeats : [SetSeatRequestModel] = []
    @Published var cinemaStrid : String? = ""
    @Published var cinemaStridTwo : String? = ""

    func getAllshows(requestBody:[String:String]){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.allShowsByFilm,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ShowsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    for show in result?.data ?? []{
                        if show.cinemaStrID == "0003"{
                            if show.shows?.count != 0{
                                cinemaStrid = show.shows?[0].strTicketType
                                cinemaStridTwo = show.shows?[1].strTicketType
                            }
                        }
                       
                      
                    }
                    shows = result?.data ?? []
                    
                }else{
                    
                }
    
            }
        }
        
    }
    
    func getSeatLayout(requestBody:[String:String],completionHandler : @escaping (SeatLayoutResponse) -> Void){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.dev,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SeatLayoutResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    if (result?.screenname?.contains("-")) == false {
                        var screenNameChange = (result?.screenname ?? "")
                        
                      //  let lastValue = screenNameChange.last
                        let newName = "\(screenNameChange.removeLast())"// + "\(String(describing: lastValue))"
                        //result?.screenname = newName
                        print(newName)
                    }else{
//                        var screenNameChange = (result?.screenname ?? "")
//                        var newName = "\(screenNameChange.removeLast())" + "\(screenNameChange)"
                        
                    }
                    seatLayouts = result
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
    
   // func setSeats(seat:Seat,layout:SeatLayout,requestBody:[String:String],completionHandler : @escaping (BookedSeatResponse) -> Void){
    func setSeats(requestBody:[String:String],completionHandler : @escaping (BookedSeatResponse) -> Void){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.setSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    if result?.responseCode == 0{
                      
                        print(result?.responseMessage ?? "")
                    }else{
//                        var seatValue : Seat
//                      //  seatValue.key = seat.key
//                        seatValue.strTransId = result?.data?.strTransID
//                        seatValue.intBookId = result?.data?.intBookID
//                        seatValue.strSeatInfo = result?.data?.strSeatInfo
////                        seatValue.amount = layout.amount
////                        seatValue.ticketType = layout.strAreaDesc
////                       seatValue.rowId = requestBody["rowId"]
//                        selectedSeats.append(seatValue)
//                        print(selectedSeats)
                    }
                  completionHandler(result!)
//                    seatLayouts = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
        
    }
  
    func resetSeats(requestBody:[String:String] ){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.resetSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
               //     completionHandler(result!)
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
        
    }
    func ticketBookingApi(movieId : String , movieName : String , bookingDate : String , showTime : String , theaterId : String , screenId : String , screenName : String , screenZone : String , snackstatus : String , numberOfTickets : String , seatNo : String , movieAmt : String ,snacksAmount : String , itemNames : String , totalAmt : String , snacksItemId : String , snacksCatId : String , snacksQuantityId : String , snacksPrice : String , promocode : String , discountPrice : String , snacksDeliveryAmt : String , snacksDeliveryStatus : String , isDeliverSts : String , totalAmtAfterDiscount :  String , completionHandler : @escaping (SaveMovieBookingModel) -> Void){
        let requestBody : [String : String]?
            requestBody = [
                "movieId" : movieId,
                "user_id" : StorageSettings().userId ,
                "movie_name" : movieName ,
                "booking_date" : bookingDate ,
                "show_time" : showTime ,
                "theatreId" : theaterId ,
                "screenId" : screenId ,
                "screen_name" : screenName ,
                "zone_in_screen" : screenZone ,
                "is_snacks_ordered" : snackstatus,
                "snacks_pickup" : "1" ,
                "no_of_tickets_booked" : numberOfTickets,
                "is_food_ordered" : "",
                "food_pickup" : "",
                "seat_no" : seatNo,
                "movie_amount" : movieAmt,
                "snacks_ordered_amt" : snacksAmount,
                "food_ordered_total_amt" : "",
                "item_name" : itemNames,
                "snacks_item_id":snacksItemId ,
                "snacks_categoryId": snacksCatId,
                "snacks_quantity": snacksQuantityId,
                "snacks_price": snacksPrice,
                "snacks_gst": snacksPrice,
                "total_amount":totalAmt,
                "promocode_id": promocode,
                "vip_card_id":"",
                "movie_discounted_amt": "",
                "no_of_tickets_discounted": "",
                "per_movie_amt": "",
                "total_amt_discounted": discountPrice,
                "total_amt_after_discounted":totalAmtAfterDiscount ,
                "snacks_delivery_at_beg_inter": isDeliverSts ,
                "is_snacks_delivered":snacksDeliveryStatus ,
                "snacks_delivery_amt":snacksDeliveryAmt,
               // "id":"22"
                "snacks_discounted_amt": "",
                "is_vip_card_used":""
            ]
        
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.saveMovieBookingsData,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SaveMovieBookingModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    completionHandler(result!)
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
        
    }
  //  "strCinemaCode" : "0002" , "strTransId" :  "20022706076" ,"lngSessionId" : "34292"
    func confirmSeatsApi(transactionId : String , sessionId : String , cinemaCOde : String , itemID : String? = nil, completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "blnPaid": "true",
              "strCardNo": "sample string 5",
              "strCardType": "Depit",
              "strCardExpiryMonth": "5",
              "strCardExpiryYear": "40",
              "strCardCVV": "sample string 9",
              "strCustomerName": StorageSettings().userName,
              "strCustomerPhone":  StorageSettings().mobileNumber,
              "strComments": "sample string 12",
              "strPickupName": "sample string 13",
            "strItemsOrder" : itemID  ,
            "strTransId" : transactionId ,
            "lngSessionId" : sessionId ,
            "strCinemaCode" : cinemaCOde
        ]
      //  finalRequest.merge(requestBody , uniquingKeysWith: +)
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.confirmSeats,requestBody: finalRequest))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConfirmSeatsModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                   completionHandler(result!)
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
    }
    func confirmSnacksItem(transactionId : String , cinemaCOde : String , itemID : String? = nil, completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "strItemsOrder" : itemID  ,
            "strTransId" : transactionId ,
            "strCinemaCode" : cinemaCOde,
            "lngSessionId" : "4" ,
            "blnPaid": "true",
              "strCardNo": "sample string 5",
              "strCardType": "Depit",
              "strCardExpiryMonth": "5",
              "strCardExpiryYear": "40",
              "strCardCVV": "sample string 9",
            "strCustomerName": StorageSettings().userName,
            "strCustomerPhone": StorageSettings().mobileNumber,
              "strComments": "nil",
              "strPickupName": "sample string 13",
        ]
      //  finalRequest.merge(requestBody , uniquingKeysWith: +)
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.confirmSnacks,requestBody: finalRequest))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConfirmSeatsModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                   completionHandler(result!)
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
    }
    func getPostString(params:[String:Any]) -> String
      {
          var data = [String]()
          for(key, value) in params
          {
              data.append(key + "=\(value)")
          }
          return data.map { String($0) }.joined(separator: "&")
      }
    func itemOrderConfirm(bookingId : String , deliveryOrTakeaway : String , beforeOrInterval : String , strBookingDetaiks : String , cinemaCode : String, completionHandler : @escaping (String) -> Void){
        let finalRequest = [

            "strCinemaCode" : cinemaCode ,
            "lngBookingId" : bookingId ,
            "strIsDelivery" : deliveryOrTakeaway ,
            "strDeliveryTime" : beforeOrInterval,
            "strBookingDetails" : strBookingDetaiks
            
        ]

        let Url = String(format: APIList().getUrlTypeTwo(url: .AFTERBOOKINGITEM))
        guard let serviceUrl = URL(string: Url) else { return }
        let parameterDictionary = finalRequest
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json; charset=utf-8", forHTTPHeaderField: "content-Type")
        let postString = self.getPostString(params: finalRequest)
             request.httpBody = postString.data(using: .utf8)

        
        let session = URLSession.shared
        print("URL",Url)
        print("Params",finalRequest)
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            DispatchQueue.main.async {
            if let data = data {
                do {
                    let gitData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completionHandler("")
                    print("Response",gitData)
                } catch {
                    print(error)
                }
            }
        }
        }.resume()
    }
    
    
    
    func finalOrderBookingApi(seatConfirmId : String , bookConfirmId : String , itemBookingId : String = "", completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "seat_confirm_id" : seatConfirmId ,
            "confirm_id" : bookConfirmId,
            "item_Booking_id" : itemBookingId
        ]
     
      //  let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.finalBookingConfirm,requestBody: finalRequest))!
        let urlRequest = (try? RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint: Endpoint.finalBookingConfirm , requestBody: finalRequest))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConfirmSeatsModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                   completionHandler(result!)
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
    }
    
    func calculateSeats()->String {
        var seatNo = ""
        var seatRow = ""
        
        if storeSelectedSeats.count > 0 {
         //   seatNo = "\(selectedSeats[0].ticketType ?? "") - "
        }

        storeSelectedSeats.forEach { item in
            seatRow += "\(item.rowId ) ,"
            seatNo +=  "\(item.rowId )\(item.srtSeatNumber.description ),"
        }
        seatNo.removeLast()
       seatRow.removeLast()

        DispatchQueue.main.async { [unowned self] in
            checkoutDetails?.seatRow = seatRow
            checkoutDetails?.seatNo = seatNo
        }

        return seatNo
    }
  
    
    func calculateTotalPrice() -> String{
        var price : Float = 0
        storeSelectedSeats.forEach { item in
            price += (Float(item.amount ) ?? 0.00 )
        }

        DispatchQueue.main.async { [unowned self] in
            if selectedSeats.count > 0{
                checkoutDetails?.ticketPrice = "\(storeSelectedSeats[0].amount )"
                checkoutDetails?.totalPrice = "\((Int(storeSelectedSeats[0].amount) ?? 0) * (selectedSeats.count))"
                    }
        }

        return  String(format: "%.2f", price)
    }
    
}
