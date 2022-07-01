//
//  DishViewCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct DishViewCell: View {
    @State var textContent : String?
    @State var amount : String?
    @State var images : String?
    @State var buttonTittle : String?
    
    var allRowData : ItemInfo
    
    @State var itemPrice : Float = 0.00
    @State var addButtonClick : Bool? = false
    @State var itemQuantity : Int = 0
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    
    var getDataValue : () -> ()
    
    var body: some View {
        HStack(spacing : 10){
            let imageUrl = "\(Endpoint.productImages.url)/\(allRowData.image ?? "")"
            SpiceKitchenFoodView(withURL: imageUrl)
            
            VStack(alignment: .leading){
                Text(textContent ?? "")
                    .font(.system(size: 13,weight: .bold))
                    .multilineTextAlignment(.leading)
                Text("₹ \(amount ?? "")")
                    .font(.system(size: 13,weight: .light))
                    .multilineTextAlignment(.leading)
            }.frame(width: 100)
                .foregroundColor(.black)
            Spacer()
            if buttonTittle == "Veg"{
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.green)
            }else{
                Image(systemName: "circle.circle.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.red)
            }
            
            if addButtonClick == false{
                Button {
                    addButtonClick = true
                    itemQuantity = 1
                    
                    let item = CartFullDataModel(foodId: allRowData.id ?? "", foodName: allRowData.itemName ?? "", foodPrice: allRowData.price ?? "", totalPrice: allRowData.price ?? "",foodQuantity : "1" , categoryId: allRowData.categoryID ?? "")
                    storeDataViewModel.items.append(item)
                    
                } label: {
                    Text("Add")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                    
                }
                .frame(width: 60, height: 8)
                .padding()
                .background(Color.red)
                .cornerRadius(.infinity)
                .buttonStyle(BorderlessButtonStyle())
            }else{
                HStack{
                    Button{
                        itemQuantity -= 1
                        for i in 0..<storeDataViewModel.items.count{
                            if storeDataViewModel.items[i].foodId == allRowData.id ?? ""{
                                
                                storeDataViewModel.items.remove(at: i)
                                if itemQuantity == 0{
                                    addButtonClick = false
                                    break
                                }else{
                                    let item = CartFullDataModel(foodId: allRowData.id ?? "", foodName: allRowData.itemName ?? "", foodPrice: allRowData.price ?? "", totalPrice: calculatePrice(price: Float(allRowData.price ?? "") ?? 0.00, quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity) , categoryId: allRowData.categoryID ?? "")
                                    storeDataViewModel.items.insert(item, at: i)
                                }
                            }
                        }
                        getDataValue()
                    }label: {
                        Text("-")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Text(String(itemQuantity))
                    Button{
                        itemQuantity += 1
                        
                        for i in 0..<storeDataViewModel.items.count{
                            if storeDataViewModel.items[i].foodId == allRowData.id ?? ""{
                             //   itemQuantity
                                storeDataViewModel.items.remove(at: i)
                                
                                let item = CartFullDataModel(foodId: allRowData.id ?? "", foodName: allRowData.itemName ?? "", foodPrice: allRowData.price ?? "", totalPrice: calculatePrice(price: Float(allRowData.price ?? "") ?? 0.00, quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity) , categoryId: allRowData.categoryID ?? "")
                                storeDataViewModel.items.insert(item, at: i)
                            }
                        }
                        
                    }label: {
                        Text("+")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: 60, height: 8)
                .padding()
                .background(Color.red)
                .cornerRadius(.infinity)
            }
            
        }.frame( height: 100)
            .onAppear(){
                for i in 0..<storeDataViewModel.items.count{
                    if storeDataViewModel.items[i].foodId == allRowData.id ?? ""{
                        addButtonClick = true
                        itemQuantity = (Int(storeDataViewModel.items[i].foodQuantity ?? "") ?? 0)
                       
                    }
                }
            }

    }
    
    
    func calculatePrice(price : Float ,quantity : Float) -> String{
        
        return String(format: "%.2f", (price * quantity))
    }
    
}
