//
//  TermsAndConditionPopup.swift
//  KFECinemas
//
//  Created by MAC on 13/09/22.
//

import SwiftUI

struct TermsAndConditionPopup: View {
    @Binding var showPopup : Bool
    var cancelClick : () -> ()
    var body: some View {
        ScrollView{
            VStack(spacing : 5){
                Text("Terms and Conditons").underline().fontWeight(.bold).font(.system(size: 22)).frame(maxWidth: .infinity,  alignment: .center).foregroundColor(.red)
                Text("1. Outside Food and Beverage is not allowed inside the cinema premises.").font(.system(size: 14))
                Text("2. Ticket required for child 3 years and above.").font(.system(size: 14)).frame(maxWidth : .infinity , alignment: .leading).multilineTextAlignment(.leading)
                Text("3. Ticket for A rated movies should not be purchased for people under 18 years of age.").font(.system(size: 14))
                Text("4. Ticket once purchased cannot be exchanged or adjusted / transferred for any other show.").font(.system(size: 14))
                Text("5. Handbags, Carry Bags, Helmets, Laptops / Tabs, Cameras and all other electronic items are not allowed inside cinema premises.").font(.system(size: 14))
                Text("6. Items like Knives, Lighter, Matchbox, Cigarettes, Firearms and all types of inflammable objects are strictly prohibited.").font(.system(size: 14))
                Text("7. Smoking is strictly not permitted inside the cinema premises. Gutkha and Pan Masala will not be allowed inside the premises.").font(.system(size: 14))
                Text("8. People under the influence of Alcohol/Drugs will not be allowed inside the cinema premises and Cinema reserves the right of Admission.").font(.system(size: 14))
                VStack{
                    Text("9. For 3D movies, charges towards usage of 3D glasses are included alongside the ticket price.").font(.system(size: 14))
                    Text("10. Seat layout page for KFE Cinemas is for representational purpose only and actual seat layout might vary.").font(.system(size: 14))
                    HStack(spacing : 40){
                        Button {
                            cancelClick()
                        } label: {
                            Text("CANCEL")
                                .foregroundColor(.white)
                                .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                                .background(Color.red)
                                .cornerRadius(8)
                            
                        }
                        Button {
                          
                            showPopup = false
                        } label: {
                            
                            Text("ACCEPT")
                                .foregroundColor(.white)
                                .frame(width: 70)
                                .padding(EdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25))
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        
                    }
                }
            }.padding(EdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 3))
        }
        
    }
}

//struct TermsAndConditionPopup_Previews: PreviewProvider {
//    static var previews: some View {
//        TermsAndConditionPopup()
//    }
//}
