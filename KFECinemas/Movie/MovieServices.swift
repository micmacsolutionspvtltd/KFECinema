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
    
    func setSeats(seat:Seat,requestBody:[String:String]){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.setSeats,requestBody: requestBody))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BookedSeatResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    var seatValue = seat
                    seatValue.strTransId = result?.data?.strTransID
                    seatValue.intBookId = result?.data?.intBookID
                    seatValue.strSeatInfo = result?.data?.strSeatInfo
                    selectedSeats.append(seatValue)
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
  
    
    
}
