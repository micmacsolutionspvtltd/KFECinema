//
//  CoreDataViewModel.swift
//  KFECinemas
//
//  Created by MAC on 25/04/22.
//

import Foundation
import CoreData
import UIKit


class DatabaseViewModel : ObservableObject{
    
//    @Published var cartAllData : CartDataStorage
    @Published var getCartDataValues : [CartDataStorage] = []
    @Published var totalAmounts : String?
    let persistantContainer : NSPersistentContainer
    
    init(){
       // self.cartAllData = cartAllData
        persistantContainer = NSPersistentContainer(name: "CartDataStorage")
        persistantContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("coredata failed")
            }
        }
        getAllDataFromTable()
    }
    
    func createDatabase(tittle : String , price : String,quantity : String,itemName : String)
    {
        let userData = CartDataStorage(context: persistantContainer.viewContext)
        userData.id = tittle
        userData.price = price
        userData.quantity = quantity
        userData.itemName = itemName
        userData.totalPrice = price
     saveData()
    }
    
    func saveData(){
        do{
            try persistantContainer.viewContext.save()
            getAllDataFromTable()
        }catch let error{
            print(error)
        }
    }
    
    func getAllDataFromTable(){
        let fetchRequest = NSFetchRequest<CartDataStorage>(entityName: "CartDataStorage")
        do{
            getCartDataValues = try persistantContainer.viewContext.fetch(fetchRequest)
            print("getCartDataValues",getCartDataValues)
        } catch let error{
            print("error",error)
        }
    }
    
    
    func deleteCartItems(id : String){
        for i in 0..<getCartDataValues.count{
            if getCartDataValues[i].id == id{
                persistantContainer.viewContext.delete(getCartDataValues[i])
                saveData()
            }
        }
       
    }
    
    
    func edirCartItemsValue(id : String,price : String,quantity : String, itemName : String){
        
        for i in getCartDataValues{
            if i.id == id{
                i.totalPrice = price
                i.quantity = quantity
              //  i.id = id
                saveData()
            }else{
                
            }
        }
    }
    func deleteAllValueCoreData(){
       
        for i in getCartDataValues{
           // if getCartDataValues[i].id == id{
                persistantContainer.viewContext.delete(i)
               
            }
        saveData()
       // }
    }
    func calculateTotalPrice() -> String{
      //  getAllDataFromTable()
        var price : Float = 0
        getCartDataValues.forEach { item in
            price += ((Float(item.price ?? "") ?? 0.00) * (Float(item.quantity ?? "") ?? 0.00) )
        }
      //  totalAmounts = String(format: "%.2f", price)
        return String(format: "%.2f", price)
    }
}
