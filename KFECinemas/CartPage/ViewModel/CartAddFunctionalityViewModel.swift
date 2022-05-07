//
//  CartAddFunctionalityViewModel.swift
//  KFECinemas
//
//  Created by MAC on 25/04/22.
//

import Foundation

struct CartFullDataModel : Codable , Identifiable , Hashable{
    var id = UUID()
    var foodId : String?
    var foodName : String?
    var foodPrice : String?
    var totalPrice : String?
    var foodQuantity : String?
}

class CartAddFunctionalityViewModel : ObservableObject{
   
    @Published var items = [CartFullDataModel]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
  
   
    init() {
       // self.promoId = promoId
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([CartFullDataModel].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
        
    }
    
    func promocodeValuesGetApi(totalAmount : String , date : String , completionHandler : @escaping((PromoCheckModel) -> Void) ){
        let params : [String : String]?
      params = [
        "user_id": StorageSettings().userId,
        "booking_date": date,
        "order_variety":"s",
        "order_total_amt":totalAmount
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.checkPromoCode,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: PromoCheckModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
        
    }
    func offerCalculationApi(promoId : String , totalAmt : String , completionHandler : @escaping((PromoCheckModel) -> Void) ){
        let params : [String : String]?
      params = [
        "promo_id": promoId,
        "order_total_amount": totalAmt,
     
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.selectedPromo,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: PromoCheckModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
        
    }
    
    func calculateTotalPrice() -> String{
      //  getAllDataFromTable()
        var price : Float = 0
        items.forEach { item in
            price += ((Float(item.foodPrice ?? "") ?? 0.00) * (Float(item.foodQuantity ?? "") ?? 0.00) )
        }
      //  totalAmounts = String(format: "%.2f", price)
        return String(format: "%.2f", price)
    }
    
}
