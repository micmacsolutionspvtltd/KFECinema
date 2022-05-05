//
//  OfferCell.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import SwiftUI

struct OfferCell: View {
    var promoCodeValue : String? 
    var body: some View {
        VStack(alignment : .leading,spacing: 8){
            HStack{
                Text("Testing")
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack{
                Text("Get 20% off up to $20")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack{
                Text("Valid on orders worth $ 100 or more")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .frame(alignment: .leading)
                    .foregroundColor(.gray)
                Spacer()
            }
            HStack{
                Text("Promo 67")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .frame(alignment: .leading)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
                    .overlay(
                           RoundedRectangle(cornerRadius: 4)
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [7.0]))
                            .foregroundColor(.white)
                            
                       )
                  //  .overlay(rou, )
                Spacer()
                Button{
                    
                } label: {
                    Text("Apply")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                        .frame(alignment: .leading)
                        .foregroundColor(.red)
                }
              
            }
        }
        .padding()//.frame(width: UIScreen.main.bounds.width)
        
    }
}

struct OfferCell_Previews: PreviewProvider {
    static var previews: some View {
        OfferCell()
            .previewLayout(.fixed(width: 0, height: 150))
            .background(Color.black)
    }
}
