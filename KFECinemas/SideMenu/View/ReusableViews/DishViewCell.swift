//
//  DishViewCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 29/03/22.
//

import SwiftUI

struct DishViewCell: View {
  //  var buttonClosure:()->Void
    var body: some View {
        HStack(spacing : 10){
            Image("food1")
                .resizable()
                .frame(width: 60, height: 60)
            VStack(alignment: .leading){
                Text("PopCorn")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                Text("$ 35")
                    .fontWeight(.light)
                    .multilineTextAlignment(.leading)
            }.frame(width: 100)
            .foregroundColor(.white)
            Spacer()
            Image(systemName: "circle.circle.fill")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
          //  HStack{
                Button {
                  //  buttonClosure()
                } label: {
                        Text("Veg")
                            .foregroundColor(.white)

                }
                .frame(width: 60, height: 15)
                .padding()
                .background(Color.red)
                .cornerRadius(.infinity)
          //  }
        }.frame( height: 100)
        
    }
}

struct DishViewCell_Previews: PreviewProvider {
    static var previews: some View {
        DishViewCell()
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 150))
           
            .padding(10)
            .background(Color.black)
    }
}
