//
//  ConcessionZoneCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/04/22.
//

import SwiftUI

struct ConcessionZoneCardView: View {
    var model:NewConceesionData
    var body: some View {
        VStack(alignment: .leading){
            if model.image == ""{
                Image("food4").renderingMode(.original).resizable().cornerRadius(5).frame(height:160).padding(EdgeInsets(top: 15, leading: 8, bottom: 8, trailing: 8))
            }else{
                let imageUrl = "\(Endpoint.finalFoodImg.url)/\(model.image ?? "")"
                FoodImageView(withURL: imageUrl)
            }
            
            VStack(alignment:.center,spacing:6) {
                Text(model.itemStrDescription ?? "").foregroundColor(.white).font(.system(size: 14,weight: .bold))
        
                Text( "₹ \(model.itemIntPrice ?? 0)").foregroundColor(.white).opacity(0.7).font(.system(size: 13,weight: .bold))
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 20, trailing: 5)).frame(maxWidth:.infinity)
           
        }.background(.black)
        
    }
}

//struct ConcessionZoneCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConcessionZoneCardView()
//    }
//}
