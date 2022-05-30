//
//  StorageSettings.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 05/04/22.
//

import Foundation
import Combine

class StorageSettings:ObservableObject{
    @Published var userId:String {
        didSet {
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }
    
    @Published var userName:String {
        didSet {
            UserDefaults.standard.set(userName, forKey: "userName")
        }
    }
    
    @Published var emailAddress:String {
        didSet {
            UserDefaults.standard.set(emailAddress, forKey: "emailAddress")
        }
    }
    
    @Published var mobileNumber:String {
        didSet {
            UserDefaults.standard.set(mobileNumber, forKey: "mobileNumber")
        }
    }
    
    @Published var cartData : [CartDataModel]{
        didSet{
            UserDefaults.standard.set(cartData , forKey: "cartData")
        }
    }
    
    init(){
        userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        emailAddress = UserDefaults.standard.string(forKey: "emailAddress") ?? ""
        mobileNumber = UserDefaults.standard.string(forKey: "mobileNumber") ?? ""
            //  cartData = UserDefaults.standard.object(forKey: "cartData") ?? [CartDataModel]()
        cartData = (UserDefaults.standard.value(forKey: "cartData")) as? [CartDataModel] ?? [CartDataModel]()
    }
}
