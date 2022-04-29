//
//  OrderHistoryViewModel.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import Foundation


class OrderHistoryViewModel : ObservableObject{
   
    @Published var getTicketHistoryData : OrderHistoryTicketModel?
    @Published var getSpiceKitcehnData : OrderHistorySpiceKitchenModel?
    @Published var getConcessionZoneData : OrderHistoryConcessionZoneModel?

    func getTicketHistoryApi(){
        let params : [String : String]?
      params = [
        "user_id": "13"
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.movieBookedOrderHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistoryTicketModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getTicketHistoryData = result
            }else{
             
            }
            }
        }
        
    }
    func getSpiceKitchenHistoryApi(){
        let params : [String : String]?
      params = [
        "user_id": "13"
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.foodOrderedHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistorySpiceKitchenModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getSpiceKitcehnData = result
            }else{
             
            }
            }
        }
        
    }
    func getConcessionZoneApi(){
        let params : [String : String]?
      params = [
        "user_id": "13"
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.snacksOrderHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistoryConcessionZoneModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getConcessionZoneData = result
            }else{
             
            }
            }
        }
        
    }
}
