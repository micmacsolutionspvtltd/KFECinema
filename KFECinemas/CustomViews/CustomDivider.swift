//
//  CustomDivider.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 19/05/22.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle().fill(.gray).frame(maxWidth: .infinity, maxHeight: 1, alignment: .center).padding(.horizontal,10)
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
//struct customAlertView : View{
//    @State var showedAlert : Bool = false
//    var tittle = "CONFIRMATION"
//    var message = "Do you want to end the session"
//    var rightSideText : String? = "Yes"
//    var leftSideText : String? = "Cancel"
//    var okAction : () -> ()
//    var cancelAction : () -> ()
//    var body : some View {
//        .alert(isPresented: $showedAlert){
//            Alert(
//                title: Text(tittle),
//                message: Text(message),
//                primaryButton: .default(Text(rightSideText), action: {
//                   okAction()
//                }),
//                secondaryButton: .cancel(Text(leftSideText), action: { // 1
//                    cancelAction()
//                })
//            )
//        }
//    
//    }
//}
