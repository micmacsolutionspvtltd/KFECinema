//
//  FoodTheaterSelectPopupView.swift
//  KFECinemas
//
//  Created by MAC on 15/06/22.
//

import SwiftUI

struct FoodTheaterSelectPopupView: View {
    var body: some View {
        VStack{
            Text("Select Theater")
                .fontWeight(.semibold)
            Divider()
            NavigationLink {
                SpiceKitchenView(pageName : "Concession Zone" , theaterID : "8")
            } label: {
                Text("Spice Cinemas")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .background(Color.red)
            .frame(width: 260)
            .padding()
            .background(Color.red)
                .cornerRadius(8)
            NavigationLink {
                SpiceKitchenView(pageName : "Concession Zone", theaterID : "2")
            } label: {
                Text("M1 Cinemas")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .frame(width: 260)
            .padding()
            .background(Color.red)
            .cornerRadius(8)

        }
    }
}

struct FoodTheaterSelectPopupView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTheaterSelectPopupView()
    }
}
