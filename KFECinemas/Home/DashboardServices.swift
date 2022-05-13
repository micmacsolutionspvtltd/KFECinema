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
    @Published var activeTheatres:[Theatre] = []
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

    
    func getAllActiveTheatres(){
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.activeTheatres))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ActiveTheatreResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    
                    activeTheatres = result?.data ?? []
              //      concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
                    
    func changePassWordApi(newPassword : String ,oldPassword : String , completionHandler : @escaping (SignUpDataModel) -> Void){
     //   let params : [String : String]
        let params : [String : String] = [
            "new_password":newPassword,
            "old_password" : oldPassword,
            "user_id" : StorageSettings().userId
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.updatePassword , requestBody : params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: SignUpDataModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    completionHandler(result!)
              //      concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
}
