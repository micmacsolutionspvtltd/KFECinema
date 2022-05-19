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
    
    func calculateSeats()->String {
        var seatNo = ""
        var seatRow = ""
        
        if selectedSeats.count > 0 {
            seatNo = "\(selectedSeats[0].ticketType ?? "") - "
        }

        selectedSeats.forEach { item in
            seatRow += "\(item.rowId ?? "") ,"
            seatNo +=  " \(item.rowId ?? "") \(item.intGridSeatNum?.description ?? ""),"
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
                    }
        }

        return  String(format: "%.2f", price)
    }
    
}
