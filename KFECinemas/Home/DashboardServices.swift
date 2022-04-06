//
//  DashboardServices.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 06/04/22.
//

import Foundation

class DashboardServices:ObservableObject {
    
    @Published var bannerImages:[BannerModel] = []
    
    func getAllBannerImages(completionHandler : @escaping((BannerResponseModel) -> Void) ){
        
 
        let endPoint = Endpoint.getBannerImages
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:endPoint))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: BannerResponseModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    bannerImages = result?.banners ?? []
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
}
