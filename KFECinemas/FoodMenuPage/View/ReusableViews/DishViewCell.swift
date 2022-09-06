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
            if allRowData.image == ""{
                Image("food1") 
                .resizable().cornerRadius(5)
                .aspectRatio(contentMode: .fit)
                .frame(width:65,height: 65)
            }else{
            SpiceKitchenFoodView(withURL: imageUrl)
            }
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

struct ConcessionZoneCell: View {
    var model:NewConceesionData
    
    @State var textContent : String?
    @State var amount : String?
    @State var images : String?
    @State var buttonTittle : String?
    
   // var allRowData : ItemInfo
    
    @State var itemPrice : Float = 0.00
    @State var addButtonClick : Bool? = false
    @State var itemQuantity : Int = 0
    @EnvironmentObject var storeDataViewModel:CartAddFunctionalityViewModel
    
    var getDataValue : () -> ()
    
    var body: some View {
        HStack(spacing : 10){
            let imageUrl = "\(Endpoint.finalFoodImg.url)/\(model.image ?? "")"
            if model.image == ""{
                Image("food1")
                    .resizable().cornerRadius(5)
                    .aspectRatio(contentMode: .fit)
                    .frame(width:65,height: 65)
            }else{
            SpiceKitchenFoodView(withURL: imageUrl)
            }
            VStack(alignment: .leading){
                Text(model.itemStrDescription ?? "")
                    .font(.system(size: 13,weight: .bold))
                    .multilineTextAlignment(.leading)
                Text("₹ \(model.itemIntPrice ?? 0)")
                    .font(.system(size: 13,weight: .light))
                    .multilineTextAlignment(.leading)
            }.frame(width: 100)
                .foregroundColor(.white)
            Spacer()
//            if buttonTittle == "Veg"{
//                Image(systemName: "circle.circle.fill")
//                    .resizable()
//                    .frame(width: 15, height: 15)
//                    .foregroundColor(.green)
//            }else{
//                Image(systemName: "circle.circle.fill")
//                    .resizable()
//                    .frame(width: 15, height: 15)
//                    .foregroundColor(.red)
//            }
            
            if addButtonClick == false{
                Button {
                    addButtonClick = true
                    itemQuantity = 1
                    
                    let item = CartFullDataModel(foodId: model.itemStrID ?? "", foodName: model.itemStrDescription ?? "", foodPrice: String(model.itemIntPrice ?? 0), totalPrice: String(model.itemIntPrice ?? 0),foodQuantity : "1" , categoryId: "")
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
                        if storeDataViewModel.items.count != 0{
                        for i in 0..<storeDataViewModel.items.count{
                            if storeDataViewModel.items[i].foodId == model.itemStrID ?? ""{
                                
                                storeDataViewModel.items.remove(at: i)
                                if itemQuantity == 0{
                                    addButtonClick = false
                                    break
                                }else{
                                    let item = CartFullDataModel(foodId: model.itemStrID ?? "", foodName: model.itemStrDescription ?? "", foodPrice: String(model.itemIntPrice ?? 0), totalPrice: calculatePrice(price: Float(model.itemIntPrice ?? 0) , quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity) , categoryId: "")
                                    storeDataViewModel.items.insert(item, at: i)
                                }
                            }
                        }
                        }else{
                            addButtonClick = false
                        }
                        getDataValue()
                    }label: {
                        Text("-")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Text(String(itemQuantity))
                    Button{
                        itemQuantity += 1
                        if storeDataViewModel.items.count != 0{
                        for i in 0..<storeDataViewModel.items.count{
                            if storeDataViewModel.items[i].foodId == model.itemStrID ?? ""{
                             //   itemQuantity
                                storeDataViewModel.items.remove(at: i)
                                
                                let item = CartFullDataModel(foodId: model.itemStrID ?? "", foodName: model.itemStrDescription ?? "", foodPrice: String(model.itemIntPrice ?? 0), totalPrice: calculatePrice(price: Float(model.itemIntPrice ?? 0) , quantity: Float(itemQuantity)) , foodQuantity : String(itemQuantity) , categoryId: "")
                                storeDataViewModel.items.insert(item, at: i)
                            }
                        }
                        }else{
                            addButtonClick = true
                            itemQuantity = 1
                            
                            let item = CartFullDataModel(foodId: model.itemStrID ?? "", foodName: model.itemStrDescription ?? "", foodPrice: String(model.itemIntPrice ?? 0), totalPrice: String(model.itemIntPrice ?? 0),foodQuantity : "1" , categoryId: "")
                            storeDataViewModel.items.append(item)
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
             //   print("come")
                if storeDataViewModel.items.count != 0{
                    for i in 0..<storeDataViewModel.items.count{
                        if storeDataViewModel.items[i].foodId == model.itemStrID ?? ""{
                            addButtonClick = true
                            itemQuantity = (Int(storeDataViewModel.items[i].foodQuantity ?? "") ?? 0)
                            
                        }
                        
                    }
                }else{
                    addButtonClick = false
                    itemQuantity = 0
                }
            }
         

    }
    
    
    func calculatePrice(price : Float ,quantity : Float) -> String{
        
        return String(format: "%.2f", (price * quantity))
    }
    
}
