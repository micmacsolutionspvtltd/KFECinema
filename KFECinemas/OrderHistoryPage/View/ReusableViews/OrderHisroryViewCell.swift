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
   @State var bookingId = "768783"
   @State var bookingSeat = "Seats : Elite - J5,J6"
    @State var snacksItems : String? = "Cake"
    @State var getConcesionZoneData :ConcessionHistoryData?
    @State var getSpiceSnacksData  = [HistorySpiceKitchen]()
    @State var setAllSnacks = ""
    var body: some View {
        VStack{
            HStack{
               Image("food3")
                    //.frame(width: 60, height: 60)
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
                    Text(theaterName)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                 //   HStack(spacing : 10){
                        Text(date)
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
                    Text(bookingId)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                    Text(bookingSeat)
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
                    Text("Snacks & Beverage")
                        .font(.system(size: 16))
                        .foregroundColor(Color.white)
 //                   if snacksItems == "3"{
//                        setAllSnacks = ""
//                        ForEach(getSpiceSnacksData , id :
//                                    \.self){ valuefull in
//
//                        }
                        Text(snacksItems ?? "")
                            .font(.system(size: 16))
                            .foregroundColor(Color.white)
//                    }
                   
                           // .frame(alignment :.trailing)
                   // }
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
