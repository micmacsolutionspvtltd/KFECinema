//
//  CartItemContentView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 02/04/22.
//

import SwiftUI

struct CartItemContentView: View {
    var tittleText = "Date Of Order"
    var buttonName = "30-03-3022"
    var imageName = "calendar"
    @State var dropDownDatas : [String] = []
    var getDataValue : () -> ()
    @State var text = "Hello World"
//    public String[] country = {"Screen 1", "Screen 2", "Screen 3", "Screen 4", "Screen 5"};
//    public String[] theatre = {"M1 Cinemas", "Spice Cinemas"};
//    public String[] shows = {"11.30 AM", "03.00 PM", "06.30 PM", "09.45 PM"};
//    public String[] seatArea = {"Premium", "Elite", "Gold"};
//    public String[] takeawaytime = {"15 Mins", "30 Mins", "45 Mins", "1 Hour"};
   
    var body: some View {
        VStack(alignment : .leading){
        HStack{
            Text(tittleText)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                Spacer()
            Button{
                getDataValue()
            }label: {
                ZStack{
                    Menu {
                        VStack{
                            ForEach(dropDownDatas , id :\.self){ names in
                                Button(action: { text = "Hello there" }) {
                                    Label(names, systemImage: "pencil")
                                }
                            }
                            
                            
                        }
                        
                    } label: {
                        ZStack{
                        Text(buttonName)
                            .foregroundColor(.white)
                        HStack{
                            Spacer()
                            Image(systemName: imageName)
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                               // .padding([.trailing],5)
                        }
                    }
                }
                }.frame(width: 150, height: 25)
                    .padding()
                    .background(Color("ColorAppGrey"))

                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                   // .background(Color("ColorAppGrey"))

            }
        }
        .padding(EdgeInsets(top: 5, leading: 10, bottom: 15, trailing: 5))
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.black)
    }
        
    }
}

//struct CartItemContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartItemContentView()
//            .previewLayout((.fixed( width: UIScreen.main.bounds.width, height : 70)))
//    }
//}
