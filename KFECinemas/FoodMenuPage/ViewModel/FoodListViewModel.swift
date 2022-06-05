//
//  FoodListViewModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 07/04/22.
//

import Foundation


class FoodListViewModel : ObservableObject{
   
    @Published var getFoodListValueGetData : FoodListModel?
    @Published var getSpiceKitcehnGetData : SpiceKitchenModel?
    @Published var getBannerImageData : FoodBannerImageModel?

    func fooddListValueShowApi(completionHandler : @escaping((FoodListModel) -> Void) ){
        let params : [String : String]?
      params = [
        "theatre_id": "2"
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getSnacksItemTheatreWise,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: FoodListModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getFoodListValueGetData = result!
                completionHandler(result!)
                   // self.delegate?.diReciveWalletBalance(data: result!)
            }else{
              //  self.delegate?.didFailWithError(error: String(error?.localizedDescription ?? ""))
            }
            }
        }
        
    }
    func spiceKitchenValueGetApi(completionHandler : @escaping((SpiceKitchenModel) -> Void) ){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        var params : [String : String]?
   
       // params = ["theatre_id":"12"]
        let urlRequest = APIList().getUrlString(url : .SPICEKITCHEN)
        
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: SpiceKitchenModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getSpiceKitcehnGetData = result!
                completionHandler(result!)
                   // self.delegate?.diReciveWalletBalance(data: result!)
            }else{
              //  self.delegate?.didFailWithError(error: String(error?.localizedDescription ?? ""))
            }
            }
        }
        
    }
    
    func getAllBannerImages(completionHandler : @escaping((FoodBannerImageModel) -> Void) ){
        
       // let urlRequest = APIList().getUrlString(url : .FOODPAGEBANNERDATA)

         let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.getAllFoodBannerImage))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: FoodBannerImageModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                    getBannerImageData = result!
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
    
    func getApiData(){
//        let Url = String(format: "http://202.83.31.153:8075/KFE_Android/KFE_Android/get_all_food_banner_image.php")
//            guard let serviceUrl = URL(string: Url) else { return }
//        let parameters: [String: Any]? = ["":""]
//            var request = URLRequest(url: serviceUrl)
//            request.httpMethod = "POST"
//            request.setValue("Application/json", forHTTPHeaderField: "Accept")
//        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? ["":""], options: .fragmentsAllowed) else {
//                return
//            }
//            request.httpBody = httpBody
//       //     request.timeoutInterval = 20
//            let session = URLSession.shared
//            session.dataTask(with: request) { (data, response, error) in
//                if let response = response {
//                    print(response)
//                }
//                if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        print(json)
//                    } catch {
//                        print(error)
//                    }
//                }
//            }.resume()
        
        
        let Url = String(format: "http://202.83.31.153:8075/KFE_Android/KFE_Android/get_food_items_data_categorywise.php")
                            guard let serviceUrl = URL(string: Url) else { return }
                        let parameters: [String: Any] = [
                            "" : ""
                                    ]
                            var request = URLRequest(url: serviceUrl)
                            request.httpMethod = "POST"
                            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed) else {
                                return
                            }
                            request.httpBody = httpBody
                           // request.timeoutInterval = 20
                            let session = URLSession.shared
                            session.dataTask(with: request) { (data, response, error) in
                                if let response = response {
                                    print(response)
                                }
                                if let data = data {
                                    do {
                                        let decoder = JSONDecoder()
                                        let response = try decoder.decode(FoodListModel.self, from: data )
                                       // let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                       // print(json)
                                        
                                    } catch {
                                        print(error)
                                    }
                                }
                            }.resume()
       // }
    }
    
}
