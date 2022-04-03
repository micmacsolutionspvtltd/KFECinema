//
//  OffersApplyView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import SwiftUI

struct OffersApplyView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>

    var body: some View {
        GeometryReader { geometry in
          //  ScrollView {
            ZStack{

                VStack{
                    ZStack{
                        Text("Offers")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                                                HStack(alignment: .bottom ){
                                                    Button(action:{
                                                        presentationMode.wrappedValue.dismiss()
                                                    }){
                                                        Image(systemName: "arrow.left")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 25.0, height: 25.0)
                                                            .foregroundColor(.white)
                            
                                                    }
                                                    Spacer()
                        }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 20, trailing: 20))
                    .frame(minWidth: geometry.size.width,maxHeight: 60)
                        .background(Color.red)
                    List{
                        ForEach(0..<5){_ in
                            OfferCell()
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                   
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color.black)

                }.frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

struct OffersApplyView_Previews: PreviewProvider {
    static var previews: some View {
        OffersApplyView()
            .background(Color.black)
    }
}
