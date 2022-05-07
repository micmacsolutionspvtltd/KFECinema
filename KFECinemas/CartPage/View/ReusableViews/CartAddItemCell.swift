//
//  CartAddItemCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct CartAddItemCell: View {
    @State var itemNames : String?
    @State var itemPrice : Float
    @State var itemQuantity : Int = 0
    @State var itemId : String?
    @State var getCartValues : CartDataStorage?
   // var dbViewModel : DatabaseViewModel? = DatabaseViewModel()
    var getDataValue : () -> ()
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(itemNames ?? "")
                    .foregroundColor(Color.white.opacity(0.7))
             //   multilineTextAlignment(.leading)
                Text("$ " + String(Float(itemPrice) * Float(itemQuantity)))
                    .foregroundColor(Color.white.opacity(0.7))
              //  multilineTextAlignment(.leading)
            }
            Spacer()
            HStack{
                Button{
                    itemQuantity -= 1
                    for i in 0..<storeDataViewModel.items.count{
                        if storeDataViewModel.items[i].foodId == itemId{
                            storeDataViewModel.items.remove(at: i)
                            if itemQuantity == 0{
                          //      addButtonClick = false
                            }else{
                                let item = CartFullDataModel(foodId: itemId ?? "", foodName: itemNames ?? "", foodPrice: String(itemPrice), totalPrice: calculatePrice(price: Float(itemPrice ) , quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity))
                                storeDataViewModel.items.insert(item, at: i)
                            }
                        }
                    }
                   // calculatePrice(price: (itemPrice ))
//                    if itemQuantity == 0{
//                      
//                        dbViewModel?.deleteCartItems(id: itemId ?? "")
//                    }else{
//                        dbViewModel?.edirCartItemsValue(id: itemId ?? "", price: String((itemPrice * (Float(itemQuantity)))), quantity: String(itemQuantity), itemName: itemNames ?? "")
//                    }
                    getDataValue()
                } label: {
                    Text("-")
                 .foregroundColor(Color.white)
                 .fontWeight(.bold)
                }.buttonStyle(PlainButtonStyle())
                Text(String(itemQuantity))
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                Button{
                    itemQuantity += 1
                    
                    for i in 0..<storeDataViewModel.items.count{
                        if storeDataViewModel.items[i].foodId == itemId{
                            storeDataViewModel.items.remove(at: i)
//                                if itemQuantity == 0{
//
//                                }else{
                            let item = CartFullDataModel(foodId: itemId ?? "", foodName: itemNames ?? "", foodPrice: String(itemPrice), totalPrice: calculatePrice(price: Float(itemPrice ) , quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity))
                            storeDataViewModel.items.insert(item, at: i)
                          //  }
                        }
                    }
                    
//                   // calculatePrice(price: (Float(itemPrice) ))
//                    dbViewModel?.edirCartItemsValue(id: itemId ?? "", price: String((itemPrice * (Float(itemQuantity)))), quantity: String(itemQuantity), itemName: itemNames ?? "")
                    getDataValue()
                } label: {
                    Text("+")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                } .buttonStyle(BorderlessButtonStyle())
                
            }
        }.padding()
    }
    func calculatePrice(price : Float ,quantity : Float) -> String{
        
        return String(format: "%.2f", (price * quantity))
    }
}

//struct CartAddItemCell_Previews: PreviewProvider {
//    static var previews: some View {
//        CartAddItemCell(itemPrice: 150, itemQuantity: 5)
//            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 80))
//            .background(Color("ColorAppGrey"))
//    }
//}
