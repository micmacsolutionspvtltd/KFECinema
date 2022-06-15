//
//  CustomLoaderView.swift
//  KFECinemas
//
//  Created by MAC on 10/06/22.
//

import SwiftUI
import Foundation

struct CircleLoader : ViewModifier{
    @Binding var isShowing : Bool
    func body(content: Content) -> some View {
        ZStack{
          content
            if isShowing{
                ZStack{
                    Circle()
                            .trim(from: 0, to: 0.7)
                            .stroke(Color.green, lineWidth: 5)
                            .frame(width: 100, height: 100)
                            .rotationEffect(Angle(degrees: 360 ))
                            .animation(Animation.default.repeatForever(autoreverses: false))
                }
            }
          
              
         //   }
             
        }
    }
}


extension View{
    func createLoader(isShowing: Binding<Bool>) -> some View{
        modifier(CircleLoader(isShowing: isShowing))
    }
}
