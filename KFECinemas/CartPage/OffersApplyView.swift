//
//  OffersApplyView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 03/04/22.
//

import SwiftUI

struct OffersApplyView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @ObservedObject var viewModel = CartAddFunctionalityViewModel()
    @EnvironmentObject var promoDataViewModel : PromoViewModel
    @State var getPromoCodeData : PromoCheckModel?
    var totalAmount : String?
    var orderDate : String?

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
                    List(getPromoCodeData?.data ?? [] , id : \.self){ promoValues in
                        //  ForEach(0..<5){_ in
                        OfferCell(promoCodeValue : promoValues,getAppplyPromoValue: {
                            promoDataViewModel.promoId = promoValues.id ?? ""
                            presentationMode.wrappedValue.dismiss()
                        })
                            .background(Color.black)
                            .cornerRadius(10)
                        //  }
                    }
                    
                    .frame(width: UIScreen.main.bounds.width)
                    .background(Color.black)
                    
                }.frame(width: UIScreen.main.bounds.width)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear(){
                viewModel.promocodeValuesGetApi(totalAmount: totalAmount ?? "", date: orderDate ?? "", completionHandler: { result in
                    getPromoCodeData = result
                })
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
