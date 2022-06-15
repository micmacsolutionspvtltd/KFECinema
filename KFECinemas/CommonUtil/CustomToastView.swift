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
    let backGroundColor : Color
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
                    .background(backGroundColor)
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
    func toast(isShowing : Binding<Bool?> , duration : TimeInterval = 2.0 , textContent : String = "Something Went Wrong" , backGroundColor : Color? = Color.red) -> some View{
        modifier(ToastModifier(isShowing: isShowing, textContentValue : textContent, backGroundColor: backGroundColor ?? Color.red, duration: duration))
    }
}

struct LoadModifier : ViewModifier{
    @Binding var isShowing : Bool

    func body(content: Content) -> some View {
        ZStack{
            content
            if isShowing{
         //       VStack{
                    ZStack{
                        if #available(iOS 14.0, *) {
                            Color(.black)
                                .ignoresSafeArea(.all)
                                .opacity(0.3)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                .scaleEffect(5)
                        } else {
                            // Fallback on earlier versions
                        }
                    
                }//.padding()
                    .onAppear(){

                    }
         //   }
            }
             
        }
    }
}

extension View{
    func loaderView(isShowing : Binding<Bool> ) -> some View{
        modifier(LoadModifier(isShowing: isShowing))
    }
}
