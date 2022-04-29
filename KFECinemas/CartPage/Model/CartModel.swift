//
//  CartModel.swift
//  KFECinemas
//
//  Created by MAC on 25/04/22.
//

import Foundation

struct CartModel : Identifiable{
    var id : String
   // var item : ItemInfo
    var quantity : String
    var totalPrice: String
}
struct CartItems : Identifiable{
    var id : String
    var itemName :  String
    var itemCost : String
    var isAdded : Bool = false 
}
