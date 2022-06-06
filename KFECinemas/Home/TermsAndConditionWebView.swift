//
//  TermsAndConditionWebView.swift
//  KFECinemas
//
//  Created by MAC on 06/06/22.
//

import SwiftUI

struct TermsAndConditionWebView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

    @State var urlName :  String?
    var pageName : String
    var body: some View {
        GeometryReader{ geometry in
            VStack{
            ZStack{
                Text(pageName)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .accentColor(Color.white)
                HStack{
                    HStack(alignment: .bottom ){
                        Button{
                            presentationMode.wrappedValue.dismiss()
                        }label: {
                              Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25.0, height: 25.0)
                                .foregroundColor(.white)
                            
                        }
                        Spacer()
                    }
                }
            } .padding(EdgeInsets(top: 30, leading: 10, bottom: 20, trailing: 20))
                    .frame(minWidth: geometry.size.width,maxHeight: 60)
                    .background(Color.red)
            Webview(url: URL(string : urlName ?? "")!)
        }
        }.navigationBarHidden(true)
       
    }
}

struct TermsAndConditionWebView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionWebView( pageName: "Terms")
    }
}
