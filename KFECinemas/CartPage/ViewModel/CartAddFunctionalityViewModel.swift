//
//  CartAddFunctionalityViewModel.swift
//  KFECinemas
//
//  Created by MAC on 25/04/22.
//

import Foundation

struct CartFullDataModel : Codable , Identifiable{
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
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([CartFullDataModel].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
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
    func updateDatas(){
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
            for i in 0..<items.count{
                if items[0].foodId == "1"{
                    
                }
            }
        }
    }
    func addDatas(id : String , name : String , price : String){
        let note = CartFullDataModel()

        // Create Array of Notes
        let notes = [note]
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(notes)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "notes")

        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
    func getAllDatas(){
        if let data = UserDefaults.standard.data(forKey: "notes") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let notes = try decoder.decode([CartFullDataModel].self, from: data)
              print(notes)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
  
    
}
