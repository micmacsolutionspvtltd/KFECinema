//
//  DishViewCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct DishViewCell: View {
  //  var buttonClosure:()->Void
    var textContent : String?
    var amount : String?
    var images : String?
    var buttonTittle : String?
    var allRowData : ItemInfo

    @State var itemPrice : Float = 0.00
    @State var addButtonClick : Bool? = false
    @State var itemQuantity : Int = 0
    @StateObject var addDataModel  = CartAddFunctionalityViewModel()
    @State var cartItems : [CartModel] = []
    var dbViewModel : DatabaseViewModel? = DatabaseViewModel()
  
  //  @Binding var addButtonClick : Bool?
    var getDataValue : () -> ()
    var body: some View {
        HStack(spacing : 10){
            let imageUrl = "\(Endpoint.productImages.url)/\(allRowData.image ?? "")"
            SpiceKitchenFoodView(withURL: imageUrl)
//                .resizable()
//                .frame(width: 60, height: 60)
            VStack(alignment: .leading){
                Text(textContent ?? "")
                    .font(.system(size: 13,weight: .bold))
                   // .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("$ \(amount ?? "")")
                    .font(.system(size: 13,weight: .light))
                    .multilineTextAlignment(.leading)
            }.frame(width: 100)
            .foregroundColor(.white)
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
          
          //  HStack{
            if addButtonClick == false{
                Button {
                    addButtonClick = true
                    itemQuantity = 1
                    itemPrice = (Float(allRowData.price ?? "0") ?? 0.0)
                    //self.addItemsToCart(cartData: CartModel(id: allRowData.id ?? "", quantity: String(itemQuantity), totalPrice: String(itemPrice)))
                    dbViewModel?.createDatabase(tittle: allRowData.id ?? "", price: allRowData.price ?? "",quantity: "1",itemName: allRowData.itemName ?? "")
                    getDataValue()
                    print("getAllDatas",dbViewModel?.getCartDataValues)
                } label: {
                        Text("Add")
                        .font(.system(size: 13))
                            .foregroundColor(.white)

                }
                .frame(width: 60, height: 8)
                .padding()
                .background(Color.red)
                .cornerRadius(.infinity)
            }else{
                HStack{
                    Button{
                        itemQuantity -= 1
                        calculatePrice(price: (Float(allRowData.price ?? "0") ?? 0.00))
                        print("getAllDatas",dbViewModel?.getCartDataValues)
                        if itemQuantity == 0{
                            addButtonClick = false
                            dbViewModel?.deleteCartItems(id: allRowData.id ?? "")
                        }else{
                            dbViewModel?.edirCartItemsValue(id: allRowData.id ?? "", price: String(itemPrice), quantity: String(itemQuantity), itemName: allRowData.itemName ?? "")
                        }
                        getDataValue()
                    }label: {
                        Text("-")
                    }
                    .buttonStyle(BorderlessButtonStyle())

                    Text(String(itemQuantity))
                    Button{
                        itemQuantity += 1
                        calculatePrice(price: (Float(allRowData.price ?? "0") ?? 0.00))
                        dbViewModel?.edirCartItemsValue(id: allRowData.id ?? "", price: String(itemPrice), quantity: String(itemQuantity), itemName: allRowData.itemName ?? "")
                        getDataValue()
                        print("getAllDatas",dbViewModel?.getCartDataValues)
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
             
               
          //  }
        }.frame( height: 100)
        
    }
    func addItemsToCart(cartData : CartModel){
        cartItems.insert(cartData, at: 0)
        print("cartItems",cartItems)
    }
    
    func removeIndex(id : String){
        let index = self.cartItems.firstIndex { (item1) in
            id == item1.id
        }
        print(index)
       // cartItems.remove(at: index!)
        print("removeItems",cartItems)
    }
    
//    func getIndex(item : ItemInfo) -> Int{
//        return addDataModel.items.firstIndex { (item1) -> Bool in
//            return item.id = item1.id
//        } ?? 0
//    }
    
    func calculatePrice(price : Float){
        itemPrice = (price * (Float(itemQuantity)))
        print("itemPrice",itemPrice)
    }
 
}

//struct DishViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DishViewCell()
//            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 150))
//
//            .padding(10)
//            .background(Color.black)
//    }
//}
