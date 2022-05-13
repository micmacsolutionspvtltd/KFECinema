//
//  CustomToastView.swift
//  KFECinemas
//
//  Created by MAC on 08/05/22.
//

import Foundation
import SwiftUI

struct ToastModifier : ViewModifier{
    @Binding var isShowing : Bool?
    let textContentValue : String
    let duration : TimeInterval
    func body(content: Content) -> some View {
        ZStack{
            content
            if isShowing ?? false{
                VStack{
                    Spacer()
                    HStack{
                        Text(textContentValue)
                            .foregroundColor(.black)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(.infinity)
                    
                }.padding()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation{
                                isShowing = false
                            }
                        }
                    }
            }
         
             
        }
    }
}

extension View{
    func toast(isShowing : Binding<Bool?> , duration : TimeInterval = 2.0 , textContent : String = "Something Went Wrong") -> some View{
        modifier(ToastModifier(isShowing: isShowing, textContentValue : textContent, duration: duration))
    }
}

