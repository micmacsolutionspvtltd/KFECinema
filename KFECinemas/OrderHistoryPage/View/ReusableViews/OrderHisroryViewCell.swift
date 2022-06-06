//
//  OrderHisroryViewCell.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import SwiftUI

struct OrderHisroryViewCell: View {
    var movieName = "Vaanam"
    var theaterName = "Sathaym"
    var amount = "$ 100"
    var date = "25/12/2022"
   @State var image = "popcorn"
   @State var bookingId = "768783"
   @State var bookingSeat = "Seats: "
    @State var snacksItems : String? = "Cake"
 
    @State var getConcesionZoneData :ConcessionHistoryData?
    @State var getSpiceSnacksData  = [HistorySpiceKitchen]()
    @State var setAllSnacks = ""
    @State var screenName : String? = ""
    @State var showTimes : String = ""
    var body: some View {
        VStack{
            HStack{
                Image(image)
                    .resizable()
                    .frame(width: 80, height: 80)
                // .padding()
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
                VStack(alignment : .leading,spacing: 5){
                    HStack(spacing : 10){
                        Text(movieName)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Text(amount)
                            .font(.system(size: 18))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack{
                        Text(theaterName)
                            .font(.system(size: 16)).multilineTextAlignment(.trailing)//.frame(maxWidth : .infinity)
                        Text(screenName ?? "")
                            .font(.system(size: 16)).multilineTextAlignment(.trailing)//.frame(maxWidth : .infinity)
                    }  .foregroundColor(Color.white)
                    //.frame(maxWidth : .infinity)
                    //   HStack(spacing : 10){
                    HStack{
                        Text(date)
                            .font(.system(size: 16)).multilineTextAlignment(.leading)
                            .foregroundColor(Color.white).frame(maxWidth : .infinity)
                    
                       
                    }
                    if bookingId != "768783"{
                        Text(bookingId)
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    }
                  
                    if bookingSeat != "Seats: "{
                        Text(bookingSeat)
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    }
                    
                    if snacksItems != ""{
                        Text("Snacks & Beverage")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                        
                        Text(snacksItems ?? "")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    }
                    
                    
                }.frame(maxWidth: .infinity)
            }.frame(maxWidth: .infinity)
        }.frame(maxWidth: UIScreen.main.bounds.width)
        
    }//.onAppear(perform: <#T##(() -> Void)?#>)
//    func snackValueChanged() -> String{
//        setAllSnacks = ""
//        ForEach(getSpiceSnacksData , id :
//                    \.self){ valuefull in
//            setAllSnacks = valuefull.itemName ?? ""
//        }
//        return setAllSnacks
//    }
}

//struct OrderHisroryViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderHisroryViewCell()
//            .previewLayout(.sizeThatFits)
//            .padding()
//            .background(Color.black)
//    }
//}
