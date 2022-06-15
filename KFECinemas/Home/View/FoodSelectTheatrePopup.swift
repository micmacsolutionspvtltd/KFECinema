//
//  FoodSelectTheatrePopup.swift
//  KFECinemas
//
//  Created by MAC on 10/06/22.
//

import SwiftUI

struct FoodSelectTheatrePopup: View {
    
        @State var docId : String?
      //  @Binding var clickAddBirthdayClicked : Bool?
       // @EnvironmentObject var customViewModel: MainViewModelFile

        var body: some View {
            VStack{
                Text("Choose Theater")
                    .fontWeight(.semibold)
                Divider()
                Button {
               //     clickAddBirthdayClicked = true
                } label: {
                    Text("Spice Kitchen")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                    

                }
                .background(Color.white)
                .frame(width: 260)
                .padding()
                .background(Color.white)
                    .cornerRadius(8)
                NavigationLink {
                   
                   // ViewBirthdayView(docId : docId ?? "")
                } label: {
                    Text("Concession Zone")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                }
                .frame(width: 260)
                .padding()
                .background(Color.white)
                .cornerRadius(8)

            }
           // .frame(width: 380, height: 300)
           // .cornerRadius(8)
           // .background(Color.init(Constants.Color.yellowColor))
        }
    }

    struct FoodSelectTheatrePopup_Previews: PreviewProvider {
        static var previews: some View {
            FoodSelectTheatrePopup()
                .previewLayout(.sizeThatFits)
        }
    }
