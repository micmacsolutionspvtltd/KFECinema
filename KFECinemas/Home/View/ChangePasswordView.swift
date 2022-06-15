//
//  ChangePasswordView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 25/04/22.
//

import SwiftUI
import Foundation

struct ChangePasswordView: View {
    @State private var existingPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmNewPassword: String = ""
    @State private var showExistingPassword = false
    @State private var showNewPassword = false
    @State private var confirmNewPasswordShow = false
    @Binding var hidePopUp : Bool?
   @ObservedObject var viewModel = DashboardServices()
    var body: some View {
        VStack {
            Text("Change Password").foregroundColor(.black).font(.title2).fontWeight(.bold)
            HStack {
                if showExistingPassword{
                    TextField("Enter your existing password", text: $existingPassword)
                    
                }else{
                    SecureField("Enter your existing Password", text: $existingPassword)
                    
                }
                Button(action:{
                    if showExistingPassword == false{
                        showExistingPassword = true
                    }else{
                        showExistingPassword = false
                    }
                }){
                    Image(systemName: showExistingPassword ? "eye" : "eye.slash").background(Color.gray)
                }
            }.padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            HStack {
                if showNewPassword{
                    TextField("Enter your new password", text: $newPassword)
                    
                }else{
                    SecureField("Enter your new Password", text: $newPassword)
                    
                }
                Button(action:{
                    if showNewPassword == false{
                        showNewPassword = true
                    }else{
                        showNewPassword = false
                    }
                }){
                    Image(systemName: showNewPassword ? "eye" : "eye.slash").background(Color.gray)
                }
                
            }.padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            HStack {
                if showNewPassword{
                    TextField("Confirm your new Password", text: $confirmNewPassword)
                    
                }else{
                    SecureField("Confirm your new Password", text: $confirmNewPassword)
                    
                }
                Button(action:{
                    if confirmNewPasswordShow == false{
                        confirmNewPasswordShow = true
                    }else{
                        confirmNewPasswordShow = false
                    }
                }){
                    
                    Image(systemName: showNewPassword ? "eye" : "eye.slash").background(Color.gray)
                    
                    
                }
                
            }.padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            
            HStack{
                Spacer()
                Button(action: {
                    hidePopUp = false

                }) {
                    Text("Cancel").fontWeight(.bold).foregroundColor(.white)

                }.frame(width: 100).padding()
                    .background(Constants.CustomColors.colorAppGrey).cornerRadius(.infinity)
                    .overlay(RoundedRectangle(cornerRadius: .infinity)
                                .stroke(Constants.CustomColors.colorAppleDark, lineWidth: 4))
                Spacer()
                
                Button{
                    viewModel.changePassWordApi(newPassword: newPassword, oldPassword: existingPassword, completionHandler: ({ result in
//                        if result.status == "Fail"{
//
//                        }else{
//
//                        }
                    }))

                }label: {
                    Text("OK").fontWeight(.bold).foregroundColor(Color.white)

                }.frame(width: 100).padding()
                    .background(Constants.CustomColors.colorAppleDark)
                    .clipShape(Capsule())

                Spacer()
            }.padding()
        }.padding()//.background(Constants.CustomColors.colorAppGrey)
            .padding(.top, 20)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(hidePopUp: .constant(false))
    }
}
