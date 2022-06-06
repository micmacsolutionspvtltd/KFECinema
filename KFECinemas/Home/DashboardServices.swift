//
//  DashboardServices.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 06/04/22.
//

import Foundation

class DashboardServices:ObservableObject {
    
     var initialAllFilms:[AllFilms] = []
     var initialSpiceKitchenItems:[SpiceKitchen] = []
     var initialConcessionZoneItems:[ConcessionZoneItem] = []
     var initialActiveTheatres:[Theatre] = []
     var initialSpiceCinemas : [AllFilms] = []
     var initialMoneCinemas  : [AllFilms] = []
    
    @Published var bannerImages:[BannerModel] = []
    @Published var allFilms:[AllFilms] = []
    @Published var spiceKitchenItems:[SpiceKitchen] = []
    @Published var concessionZoneItems:[ConcessionZoneItem] = []
    @Published var activeTheatres:[Theatre] = []
    @Published var spiceCinemas : [AllFilms] = []
    @Published var moneCinemas  : [AllFilms] = []
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
                    initialAllFilms = result?.data ?? []
                    allFilms = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func getParticularCinemaApi(cinemaCode : String){
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.allFilmsByCinema ,  requestBody : ["cinemacode" : cinemaCode]))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: AllFilmsResponse.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                    if cinemaCode == "0002"{
                        initialSpiceCinemas = result?.data ?? []
                        spiceCinemas = result?.data ?? []
                    }else{
                        moneCinemas = result?.data ?? []
                    }
                  
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
                    initialSpiceKitchenItems = result?.data ?? []
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
                    initialConcessionZoneItems = result?.data ?? []
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
                    
                    initialActiveTheatres = result?.data ?? []
                    activeTheatres = result?.data ?? []
              //      concessionZoneItems = result?.data ?? []
                }else{
                    
                }
               
           
            }
        }
    }
    
    func searhFilter(text:String){
        
        if text.count > 0 {
            
            allFilms = initialAllFilms.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            
            spiceKitchenItems = initialSpiceKitchenItems.filter { value in
                value.itemInfo!.itemName!.lowercased().contains(text.lowercased())
            }
            concessionZoneItems = initialConcessionZoneItems.filter { value in
                value.itemInfo!.itemName!.lowercased().contains(text.lowercased())
            }
            activeTheatres = initialActiveTheatres.filter { value in
                value.cinemaStrName!.lowercased().contains(text.lowercased())
            }
            spiceCinemas = initialSpiceCinemas.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            moneCinemas = initialMoneCinemas.filter { value in
                value.filmStrTitle!.lowercased().contains(text.lowercased())
            }
            
        } else{
            allFilms = initialAllFilms
            spiceKitchenItems = initialSpiceKitchenItems
            concessionZoneItems = initialConcessionZoneItems
            activeTheatres = initialActiveTheatres
            spiceCinemas = initialSpiceCinemas
            moneCinemas = initialMoneCinemas
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
