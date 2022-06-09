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
    @Published var getKitchenSnacksData = [String]()
    @Published var getConcessionSnacksData = [String]()
    @Published var getTicketSnacksData = [String]()
    @Published var getTicketSnacksPrice = [String]()
    func getTicketHistoryApi(){
        let params : [String : String]?
      params = [
        "user_id": StorageSettings().userId
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.movieBookedOrderHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistoryTicketModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                var snackItemName = ""
                var snacksPrice = ""
                self.getTicketSnacksData.removeAll()
                self.getTicketSnacksPrice.removeAll()
                for values in result?.data ?? []{
                    snackItemName = ""
                    snacksPrice = ""
                    for finalValue in values.snacksDetails ?? []{
                        if snackItemName == ""{
                            snackItemName = "\(finalValue.quantity ?? "") X \(finalValue.itemName ?? "")"
                            snacksPrice = finalValue.orderTotalPrice ?? ""
                        }else{
                           snackItemName = "\(snackItemName) , \(finalValue.quantity ?? "") X  \(finalValue.itemName ?? "")"
                        }
                    }
                    self.getTicketSnacksData.append(snackItemName)
                    self.getTicketSnacksPrice.append(snacksPrice)
                }
                self.getTicketHistoryData = result
            }else{
             
            }
            }
        }
        
    }
    func getSpiceKitchenHistoryApi(){
        let params : [String : String]?
      params = [
        "user_id": StorageSettings().userId
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.foodOrderedHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistorySpiceKitchenModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
                if restValue == true{
                var snackItemName = ""
                    self.getKitchenSnacksData.removeAll()
                for value in result?.data ?? []{
                    snackItemName = ""
                    for finalValue in value{
                        if snackItemName == ""{
                            snackItemName = "\(finalValue.quantity ?? "") X \(finalValue.itemName ?? "")"
                        }else{
                           snackItemName = "\(snackItemName) , \(finalValue.quantity ?? "") X  \(finalValue.itemName ?? "")"
                        }
                    }
                    self.getKitchenSnacksData.append(snackItemName)
                }
                self.getSpiceKitcehnData = result
            }else{
             
            }
            }
        }
        
    }
    func getConcessionZoneApi(){
        let params : [String : String]?
      params = [
        "user_id": StorageSettings().userId
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.snacksOrderHistory,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: OrderHistoryConcessionZoneModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                var snackItemName = ""
                    self.getConcessionSnacksData.removeAll()
                for value in result?.data ?? []{
                    snackItemName = ""
                    for finalValue in value{
                        if snackItemName == ""{
                            snackItemName = "\(finalValue.quantity ?? "") X \(finalValue.itemName ?? "")"
                        }else{
                           snackItemName = "\(snackItemName) , \(finalValue.quantity ?? "") X  \(finalValue.itemName ?? "")"
                        }
                    }
                    self.getConcessionSnacksData.append(snackItemName)
                }
                self.getConcessionZoneData = result
            }else{
             
            }
            }
        }
        
    }
}
