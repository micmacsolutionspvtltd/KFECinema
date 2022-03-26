//
//  StorageManager.swift
//  FoodSoldiers
//
//  Created by MAC on 01/07/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

class StorageManager {
    static let sharedInstance = StorageManager()
    
    
    func storeMobileNumber(mobile:String){
        UserDefaults.standard.set(mobile, forKey: Constants.StorageKeys.mobileNumber)
    }
    
   
    func fetchMobileNumber(){
        UserDefaults.standard.value(forKey: Constants.StorageKeys.mobileNumber)
    }
    func storeUserName(name : String){
        UserDefaults.standard.set(name, forKey: Constants.AddAccountKeys.placeholder1)
    }
    func getUserName()-> String{
        guard let name = UserDefaults.standard.string(forKey: Constants.AddAccountKeys.placeholder1) else {
            return ""
        }
        return name

    }
    func storeDemoCompleted(state:Bool){
        UserDefaults.standard.set(state, forKey: Constants.demoScreenShown)
    }
    func isDemoCompleted()->Bool {
      return  UserDefaults.standard.bool(forKey: Constants.demoScreenShown)
    }
    func storeUserDetails(dict:[String:Any]){
        UserDefaults.standard.set(dict, forKey: Constants.UserDefaultkeys.userDetails)
    }
    func fetchUserDetails()->[String:Any]?{
        return UserDefaults.standard.dictionary(forKey: Constants.UserDefaultkeys.userDetails)
    }
    
    func storePincode(pincode:String){
        UserDefaults.standard.set(pincode,forKey: Constants.UserDefaultkeys.pincode)
    }
    
    func fetchPincode()-> String {
        guard let pincode = UserDefaults.standard.string(forKey: Constants.UserDefaultkeys.pincode) else {
            return ""
        }
        return pincode
    }
    
    func storeShippingCharges(charges:Double){
        UserDefaults.standard.set(charges,forKey: Constants.UserDefaultkeys.shippingCharges)
    }
    
    func fetchShippingCharges()->Double {
        return UserDefaults.standard.double(forKey: Constants.UserDefaultkeys.shippingCharges)
    }
    
    func storeStateId(id:String){
        UserDefaults.standard.set(id, forKey: Constants.UserDefaultkeys.stateId)
    }
    
    func fetchStateId()->String?{
        return UserDefaults.standard.string(forKey: Constants.UserDefaultkeys.stateId)
    }
    
    func storeProfileDetails(dict:[String:Any]){
        UserDefaults.standard.set(dict, forKey: Constants.UserDefaultkeys.profileDetails)
    }
    
    func fetchProfileDetails()->[String:Any]?{
        return UserDefaults.standard.dictionary(forKey: Constants.UserDefaultkeys.profileDetails)
    }
    
    func storeProductType(type:Int){
        UserDefaults.standard.set(type, forKey: Constants.UserDefaultkeys.productType)
    }
    func fetchProductType()->Int?{
        return UserDefaults.standard.integer(forKey: Constants.UserDefaultkeys.productType)
    }
    
    func storeQrStatus(status:Bool){
        UserDefaults.standard.set(status, forKey: Constants.UserDefaultkeys.qrEnabled)
    }
    
    func isQrEnabled()->Bool{
       return UserDefaults.standard.bool(forKey: Constants.UserDefaultkeys.qrEnabled)
    }
    
    func storeDashboardStatus(){
        UserDefaults.standard.set(true,forKey: Constants.UserDefaultkeys.isDashboardEnabled)
    }
    
    func fetchDashboardStatus()->Bool{
        return UserDefaults.standard.bool(forKey: Constants.UserDefaultkeys.isDashboardEnabled)
    }
    
    func storeChildAccountStatus(id:String){
        UserDefaults.standard.set(id,forKey: Constants.UserDefaultkeys.isChildAccountEnabled)
    }
    
    func fetchChildAccountStatus()->String {
        
        if let value = UserDefaults.standard.string(forKey: Constants.UserDefaultkeys.isChildAccountEnabled) {
            return value
        }else {
            return "0"
        }
        
    }
    


}
