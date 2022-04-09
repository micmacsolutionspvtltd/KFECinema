//
//  DashboardServices.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 06/04/22.
//

import Foundation

class DashboardServices:ObservableObject {
    
    @Published var bannerImages:[BannerModel] = []
    @Published var allFilms:[AllFilms] = []
    @Published var spiceKitchenItems:[SpiceKitchen] = []
    @Published var concessionZoneItems:[ConcessionZoneItem] = []
    
    func getAllBannerImages(){
        
 
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getBannerImages))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BannerResponseModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    bannerImages = result?.banners ?? []
                }else{
                    
                }
               
           
            }
        }
        
    }
    
    func getAllFilms(){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.allFilms))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: AllFilmsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    allFilms = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func getAllSpiceKitchenItems(){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getAllItems))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SpiceKitchenResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    spiceKitchenItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func getConcessionZoneItems(){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getAllSnacksItems))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConcessionZoneResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    
}
