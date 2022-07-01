//
//  SeatAreaChangePopupView.swift
//  KFECinemas
//
//  Created by MAC on 23/06/22.
//

import SwiftUI

struct SeatAreaChangePopupView: View {
    
    @Binding var hidePopup : Bool?
    
    
    var changeCategory : () -> ()
    
    
    var body: some View {
        VStack(spacing: 20){
            Text("Selected seat not same Area please confirm to reset before selected seats")
                .fontWeight(.semibold)
                .frame(width: 270)
                .padding()
            
            
            HStack(spacing : 40){
                Button {
                    hidePopup = false
                } label: {
                    Text("CANCEL")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                        .background(Color.red)
                        .cornerRadius(8)
                    
                }
                Button {
                    changeCategory()
                    
                } label: {
                    
                    Text("OK")
                        .foregroundColor(.white)
                        .frame(width: 60)
                        .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                        .background(Color.red)
                        .cornerRadius(8)
                }
                
            }
            
            
        }
        .padding([.bottom],30).background(Color.white)
        .cornerRadius(10)
    }
}
struct SeatAreaChangePopupView_Previews: PreviewProvider {
    static var previews: some View {
        SeatAreaChangePopupView(hidePopup: .constant(false), changeCategory: {
            
        }).previewLayout(.fixed(width: 320, height: 200)).cornerRadius(10)
            
    }
}
