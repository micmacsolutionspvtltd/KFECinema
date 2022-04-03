//
//  CartItemContentView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 02/04/22.
//

import SwiftUI

struct CartItemContentView: View {
    var tittleText = "Date Of Order"
    var buttonName = "30-03-3022"
    var imageName = "calendar"
    var body: some View {
        VStack(alignment : .leading){
        HStack{
            Text(tittleText)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                Spacer()
            Button{
                
            }label: {
                ZStack{
                    Text(buttonName)
                        .foregroundColor(.white)
                    
                    HStack{
                        Spacer()
                        Image(systemName: imageName)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                           // .padding([.trailing],5)
                        
                        
                    }
                }.frame(width: 150, height: 25)
                    .padding()
                    .background(Color("ColorAppGrey"))

                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                   // .background(Color("ColorAppGrey"))

            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 5))
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.black)
    }
        
    }
}

struct CartItemContentView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemContentView()
            .previewLayout((.fixed( width: UIScreen.main.bounds.width, height : 70)))
    }
}
