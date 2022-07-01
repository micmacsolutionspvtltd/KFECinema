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
    @Published var selectedScreen:BookSeatModel?
    @Published var checkoutDetails:CheckoutModel?
    @Published var cinemaStrid : String? = ""

    func getAllshows(requestBody:[String:String]){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.allShowsByFilm,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ShowsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    for show in result?.data ?? []{
                        if show.shows?.count != 0{
                            cinemaStrid = show.shows?[0].strTicketType
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
                    seatLayouts = result
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
    
    func setSeats(seat:Seat,layout:SeatLayout,requestBody:[String:String],completionHandler : @escaping (BookedSeatResponse) -> Void){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.setSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    if result?.responseCode == 0{
                      
                        print(result?.responseMessage ?? "")
                    }else{
                        var seatValue = seat
                        seatValue.key = seat.key
                        seatValue.strTransId = result?.data?.strTransID
                        seatValue.intBookId = result?.data?.intBookID
                        seatValue.strSeatInfo = result?.data?.strSeatInfo
                        seatValue.amount = layout.amount
                        seatValue.ticketType = layout.strAreaDesc
                       seatValue.rowId = requestBody["rowId"]
                        selectedSeats.append(seatValue)
                        print(selectedSeats)
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
    func confirmSeatsApi(transactionId : String , sessionId : String , cinemaCOde : String , completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "blnPaid": "true",
              "strCardNo": "sample string 5",
              "strCardType": "Depit",
              "strCardExpiryMonth": "5",
              "strCardExpiryYear": "40",
              "strCardCVV": "sample string 9",
              "strCustomerName": "sample string 10",
              "strCustomerPhone": "sample string 11",
              "strComments": "sample string 12",
              "strPickupName": "sample string 13",
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
    
    func finalOrderBookingApi(seatConfirmId : String , bookConfirmId : String , completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "seat_confirm_id" : seatConfirmId ,
            "confirm_id" : bookConfirmId
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
        
        if selectedSeats.count > 0 {
         //   seatNo = "\(selectedSeats[0].ticketType ?? "") - "
        }

        selectedSeats.forEach { item in
            seatRow += "\(item.rowId ?? "") ,"
            seatNo +=  "\(item.rowId ?? "")\(item.intGridSeatNum?.description ?? ""),"
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
        selectedSeats.forEach { item in
            price += (Float(item.amount ?? 0) )
        }

        DispatchQueue.main.async { [unowned self] in
            if selectedSeats.count > 0{
                checkoutDetails?.ticketPrice = "\(selectedSeats[0].amount ?? 0)"
                checkoutDetails?.totalPrice = "\(Int(selectedSeats[0].amount ?? 0) * (selectedSeats.count))"
                    }
        }

        return  String(format: "%.2f", price)
    }
    
}
