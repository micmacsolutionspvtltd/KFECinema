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
    var categoryId : String?
}

class CartAddFunctionalityViewModel : ObservableObject{
   
    @Published var items:[CartFullDataModel] {
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
    func deleteAllDatas(){
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
    func offerCalculationApi(promoId : String , totalAmt : String , completionHandler : @escaping((PromoAmtCalculateModel) -> Void) ){
        let params : [String : String]?
      params = [
        "promo_id": promoId,
        "order_total_amount": totalAmt,
     
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.selectedPromo,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: PromoAmtCalculateModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
        
    }
    func orderSnackItem(orderDate :  String ,itemId : String , categoryId : String ,quantity : String , price : String , gst : String ,promoId : String , totalAmt : String ,pickUpCounter : String ,theaterId : String , screenId : String , seatNo : String , totalPrice : String ,showTime : String ,seatRow : String , promoCode : String , discountPrice : String , amountDiscounted : String, completionHandler : @escaping((FoodOrderResponseModel) -> Void) ){
        let params : [String : String]?
        params = [
            "user_id" : StorageSettings().userId,
            "item_id" : itemId,
            "categoryId": categoryId,
            "sub_categoryId" : categoryId,
            "quantity" : quantity,
            "price" : price,
            "gst" : quantity,
            "payment_type" : "1",
            "ordered_during" : "0",
            "order_total_amount" : totalPrice,
            "theatre_id" : theaterId,
            "screen_id" : screenId,
            "seat_no" : seatNo,
            "show_time" : showTime,
            "zone" : seatRow,
            "deliver_to_seat_or_pickup_at_counter" : pickUpCounter,
            "order_date" : orderDate,
            "promocode_id" : promoCode,
            "total_amt_discounted" : amountDiscounted,
            "total_amt_after_discounted" : discountPrice,
            "is_vip_card_used" : "",
            "vip_card_id" : "",
        ]
   
            
//        params = [
//            "user_id" : "42",
//            "item_id" : "16",
//            "categoryId": "4",
//            "sub_categoryId" : "",
//            "quantity" : "1",
//            "price" : "980",
//            "gst" : "16",
//            "payment_type" : "1",
//            "ordered_during" : "0",
//            "order_total_amount" : "980",
//            "theatre_id" : "M1 cinemas",
//            "screen_id" : "Screen 1",
//            "seat_no" : "",
//            "show_time" : "06.00AM",
//            "zone" : "",
//            "deliver_to_seat_or_pickup_at_counter" : "1",
//            "order_date" : "2022-05-28",
//            "promocode_id" : "",
//            "total_amt_discounted" : "",
//            "total_amt_after_discounted" : discountPrice,
//            "is_vip_card_used" : "",
//            "vip_card_id" : "",
//        ]
        
        
        
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.insertOrderItem,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: FoodOrderResponseModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
        
    }
    func orderConcessionZoneSnacks(orderDate :  String ,itemId : String , categoryId : String ,quantity : String , price : String , gst : String ,promoId : String , totalAmt : String ,pickUpCounter : String ,theaterId : String , screenId : String , seatNo : String , totalPrice : String ,showTime : String ,seatRow : String , promoCode : String , discountPrice : String , amountDiscounted : String , orderConfirmId : String, completionHandler : @escaping((String) -> Void) ){
        let params : [String : String]?
        params = [
            "order_date" : orderDate ,
            "user_id" : StorageSettings().userId,
            "item_id" : itemId,
            "categoryId": categoryId,
            "sub_categoryId": "",
            "quantity" : quantity,
            "price" : price,
            "gst" : categoryId,
            "payment_type" : "1",
            "ordered_during" : "0",
            "deliver_to_seat_or_pickup_at_counter" : "1",
            "theatre_id" : theaterId,
            "screen_id" : screenId,
            "seat_no" : seatNo,
            "order_total_price" : totalPrice,
            "show_time" : showTime,
            "zone" : seatRow,          
            "promocode_id" : promoCode,
            "total_amt_discounted" : amountDiscounted,
            "total_amt_after_discounted" : discountPrice,
            "is_vip_card_used" : "",
            "vip_card_id" : "",
            "snacks_delivery_at_beg_inter" : "1",
            "order_confirm_id":orderConfirmId
        ]
        //http://202.83.31.153:8075/KFE_Android/insert_snacks_ordered_items.php?order_date=2022-08-26&order_confirm_id=WB4N2WM&user_id=13&item_id=636&categoryId=4&sub_categoryId=&quantity=1&price=120.0&gst=636&payment_type=1&ordered_during=0&deliver_to_seat_or_pickup_at_counter=1&theatre_id=Spice Cinemas&screen_id=Screen 2&seat_no=2&order_total_price=120.00&show_time=Afternoon Show&zone=Elite&deliver_to_seat_or_pickup_at_counter=1&order_date=2022-08-26&promocode_id=&total_amt_discounted=&total_amt_after_discounted=130.0&is_vip_card_used=&vip_card_id=&snacks_delivery_at_beg_inter=1
//        params = [
//            "order_date" : "2022-05-26" ,
//            "user_id" : "42",
//            "item_id" : "17",
//            "categoryId": "8",
//            "quantity" : "1",
//            "price" : "380",
//            "gst" : "17",
//            "payment_type" : "1",
//            "ordered_during" : "0",
//            "deliver_to_seat_or_pickup_at_counter" : "1",
//            "theatre_id" : "M1 cinemas",
//            "screen_id" : "Screen 1",
//            "seat_no" : "",
//            "order_total_price" : "380",
//            "show_time" : "06.00AM",
//            "zone" : "",
//            "promocode_id" : "",
//            "total_amt_discounted" : "",
//            "total_amt_after_discounted" : "390",
//            "is_vip_card_used" : "",
//            "vip_card_id" : "",
//            "snacks_delivery_at_beg_inter" : "1",
//        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.insertSnacksOrderItem,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: FoodOrderResponseModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler("")
            }else{
                completionHandler("")
            }
            }
        }
        
    }
    func confirmSnacksItem( cinemaCOde : String , itemID : String, completionHandler : @escaping (ConfirmSeatsModel) -> Void){
        let finalRequest = [
            "strItemsOrder" : itemID  ,
           // "strTransId" : transactionId ,
            "strCinemaCode" : cinemaCOde,
            "lngSessionId" : "4" ,
            "blnPaid": "true",
              "strCardNo": "sample string 5",
              "strCardType": "Depit",
              "strCardExpiryMonth": "5",
              "strCardExpiryYear": "40",
              "strCardCVV": "sample string 9",
            "strCustomerName": StorageSettings().userName,
            "strCustomerPhone": StorageSettings().mobileNumber,
              "strComments": "nil",
              "strPickupName": "sample string 13",
        ]
      //  finalRequest.merge(requestBody , uniquingKeysWith: +)
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.confirmSnacks,requestBody: finalRequest))!
    
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ConfirmSeatsModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true{
                   completionHandler(result!)
                 print("Seat reset has been done")
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
    
    func calculateTotalQuantity() -> String{
        var foodQuantity : Int = 0
        items.forEach { item in
            foodQuantity += (Int(item.foodQuantity ?? "") ?? 0)
            
        }
        return String(foodQuantity)
    }
    
}
struct FoodOrderResponseModel: Codable {
    let status: Int?
    let reason: String?
    let orderId : String?
}
