//
//  CartAddFunctionalityViewModel.swift
//  KFECinemas
//
//  Created by MAC on 25/04/22.
//

import Foundation


class CartAddFunctionalityViewModel : NSObject,ObservableObject{
    @Published var items : [ItemInfo] = []
    @Published var cartItems : [CartModel] = []
    
    func addItemsToCart(cartData : CartModel){
        cartItems.append(cartData)
        print("cartItems",cartItems)
    }
    func removeIndex(id : String){
        let index = self.cartItems.firstIndex { (item1) in
            id == item1.id
        }
        print(index)
        cartItems.remove(at: index!)
        print("removeItems",cartItems)
    }
    func addToCart(item : ItemInfo){
        
//        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !(item.isAdded ?? false)
//        
//        if item.isAdded ?? false{
//            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
//            return
//        }
      //  self.cartItems.append(CartModel(item: item, quantity: 1))
    }
    
    func getIndex(item : ItemInfo , isCartIndex : Bool) -> Int{
        let index = self.items.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        let cartIndex = self.cartItems.firstIndex { (item1) -> Bool in
            return item.id == item1.id
        } ?? 0
        return isCartIndex ? cartIndex : index
    }
    
}
