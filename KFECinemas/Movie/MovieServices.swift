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
    func getAllshows(requestBody:[String:String]){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.allShowsByFilm,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ShowsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    shows = result?.data ?? []
                }else{
                    
                }
    
            }
        }
        
    }
    
    func getSeatLayout(requestBody:[String:String]){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.dev,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SeatLayoutResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    seatLayouts = result
                }else{
                    
                }
               
           
            }
        }
        
    }
    
    func setSeats(seat:Seat,layout:SeatLayout,requestBody:[String:String]){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.setSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    var seatValue = seat
                    seatValue.strTransId = result?.data?.strTransID
                    seatValue.intBookId = result?.data?.intBookID
                    seatValue.strSeatInfo = result?.data?.strSeatInfo
                    seatValue.amount = layout.amount
                    seatValue.ticketType = layout.strAreaDesc
                   seatValue.rowId = requestBody["rowId"]
                    selectedSeats.append(seatValue)
                    print(selectedSeats)
//                    seatLayouts = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
        
    }
  
    func resetSeats(requestBody:[String:String]){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.resetSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                 print("Seat reset has been done")
                }else{
                    
                }
               
           
            }
        }
        
    }
    func ticketBookingApi(movieId : String , movieName : String , bookingDate : String , showTime : String , theaterId : String , screenId : String , screenName : String , screenZone : String , snackstatus : String , numberOfTickets : String , seatNo : String , movieAmt : String ,snacksAmount : String , itemNames : String , totalAmt : String , snacksItemId : String , snacksCatId : String , snacksQuantityId : String , snacksPrice : String , promocode : String , discountPrice : String , snacksDeliveryAmt : String , snacksDeliveryStatus : String , isDeliverSts : String){
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
                "snacks_gst":"1",
                "total_amount":totalAmt,
                "promocode_id": promocode,
                "vip_card_id":"",
                "movie_discounted_amt": "",
                "no_of_tickets_discounted": "",
                "per_movie_amt": "",
                "total_amt_discounted": discountPrice,
                "total_amt_after_discounted":totalAmt ,
                "snacks_delivery_at_beg_inter": isDeliverSts ,
                "is_snacks_delivered":snacksDeliveryStatus ,
                "snacks_delivery_amt":snacksDeliveryAmt,
               // "id":"22"
                "snacks_discounted_amt": "",
                "is_vip_card_used":""
            ]
        
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.saveMovieBookingsData,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
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
