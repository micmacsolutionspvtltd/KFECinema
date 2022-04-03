//
//  CartView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 31/03/22.
//

import SwiftUI

struct CartView: View {
    @State private var selected = 1
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    
                }){
                    Image(systemName:"chevron.left").foregroundColor(.white)
                }
                Spacer()
                Text("Cart").foregroundColor(.white)
                Spacer()
            }.padding().frame(maxWidth:.infinity).background(Constants.CustomColors.colorAppleDark)
            Picker("Menu", selection: $selected) {
                Text("Deliver").foregroundColor(.white).tag(1)
                Text("Takeaway").foregroundColor(.white).tag(2)
            }.pickerStyle(.menu)
            Spacer()
        }.background(.black)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
