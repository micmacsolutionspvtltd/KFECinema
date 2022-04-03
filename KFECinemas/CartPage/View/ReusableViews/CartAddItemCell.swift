//
//  CartAddItemCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 01/04/22.
//

import SwiftUI

struct CartAddItemCell: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Classic Ceaser salad")
                    .foregroundColor(Color.white.opacity(0.7))
             //   multilineTextAlignment(.leading)
                Text("100")
                    .foregroundColor(Color.white.opacity(0.7))
              //  multilineTextAlignment(.leading)
            }
            Spacer()
            HStack{
                Button{
                    
                } label: {
                    Text("-")
                 .foregroundColor(Color.white)
                 .fontWeight(.bold)
                }
                Text("1")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                Button{
                    
                } label: {
                    Text("+")
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                }
            }
        }.padding()
    }
}

struct CartAddItemCell_Previews: PreviewProvider {
    static var previews: some View {
        CartAddItemCell()
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 80))
            .background(Color("ColorAppGrey"))
    }
}
