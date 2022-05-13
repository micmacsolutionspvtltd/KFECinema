//
//  TheatreCardView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/05/22.
//

import SwiftUI

struct TheatreCardView: View {
    var model:Theatre
    var body: some View {
        VStack(alignment: .leading){
            Image("m1logo").renderingMode(.original).resizable().cornerRadius(5).frame(height:160).padding(EdgeInsets(top: 15, leading: 8, bottom: 8, trailing: 8))
            VStack(alignment:.center,spacing:6) {
                Text(model.cinemaStrName ?? "").foregroundColor(.white).font(.system(size: 14,weight: .bold))
        
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 20, trailing: 5)).frame(maxWidth:.infinity)
           
        }.background(.black)
        
    }
}

//struct TheatreCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        TheatreCardView(model: Theatre(cinemaStrID:2))
//    }
//}
