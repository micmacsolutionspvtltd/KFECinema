//
//  FoodListViewModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 07/04/22.
//

import Foundation


class FoodListViewModel : ObservableObject{
   
    @Published var getFoodListValueGetData : FoodListModel?
    @Published var getSpiceKitcehnGetData : [SpiceKitchenModelElement] = []
    
    func fooddListValueShowApi(completionHandler : @escaping((FoodListModel) -> Void) ){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        var params : [String : String]?
   
        params = ["theatre_id":"12"]
        let urlRequest = APIList().getUrlString(url : .FOODLISTAPI)
        
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: FoodListModel.self) { (restValue, result, error) in
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
    func spiceKitchenValueGetApi(){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        var params : [String : String]?
   
       // params = ["theatre_id":"12"]
        let urlRequest = APIList().getUrlString(url : .SPICEKITCHEN)
        
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: SpiceKitchenModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getSpiceKitcehnGetData = result!
              //  completionHandler(result!)
                   // self.delegate?.diReciveWalletBalance(data: result!)
            }else{
              //  self.delegate?.didFailWithError(error: String(error?.localizedDescription ?? ""))
            }
            }
        }
        
    }
}
