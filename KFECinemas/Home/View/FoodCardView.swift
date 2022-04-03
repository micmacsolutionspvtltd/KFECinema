//
//  MovieCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct FoodCardView: View {
    var model:MovieModel
    var body: some View {
        VStack(alignment: .leading){
            Image("food4").renderingMode(.original).resizable().cornerRadius(5).frame(height:160).padding(EdgeInsets(top: 15, leading: 8, bottom: 8, trailing: 8))
            VStack(alignment:.center,spacing:6) {
                Text(model.name).foregroundColor(.white).font(.system(size: 14,weight: .bold))
        
                Text("Rs 189").foregroundColor(.white).opacity(0.7).font(.system(size: 13,weight: .bold))
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)).frame(maxWidth:.infinity)
           
        }.background(.black)
        
    }
}

struct FoodCardView_Previews: PreviewProvider {
    static var previews: some View {
        FoodCardView(model: MovieModel(name: "Naveen")).previewLayout(.fixed(width: 240, height: 400)).background(.black)
    }
}


struct FoodModel: Identifiable {
    let id = UUID()
    let name: String
}
