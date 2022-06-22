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
    @Binding var showToast : Bool?
    @Binding var hidePopUp : Bool?
    @Binding var toastMsg : String
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
                if confirmNewPasswordShow{
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
                    
                    Image(systemName: confirmNewPasswordShow ? "eye" : "eye.slash").background(Color.gray)
                    
                    
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
                        .stroke(Color.red, lineWidth: 4))
                Spacer()
                
                Button{
                   if existingPassword.count == 0 {
                        toastMsg = "Please enter old password "
                        showToast = true
                        return
                    }else if newPassword.count == 0 {
                        toastMsg = "Please enter New password "
                        showToast = true
                        return
                    }else if confirmNewPassword.count == 0  {
                        toastMsg = "Please enter New password "
                        showToast = true
                        return
                    }else if newPassword != confirmNewPassword{
                        toastMsg = "Password new password and confirm password not same"
                        showToast = true
                        return
                    }
                    viewModel.changePassWordApi(newPassword: newPassword, oldPassword: existingPassword, completionHandler: ({ result in
                        if result.status == "Fail"{
                            toastMsg = "Entered password incorrect please try again"
                            showToast = true
                        }else{
                            toastMsg = "Password changed suceessfully"
                            showToast = true
                            hidePopUp = false
                        }
                    }))

                }label: {
                    Text("OK").fontWeight(.bold).foregroundColor(Color.white)

                }.frame(width: 100).padding()
                    .background(Color.red)
                    .clipShape(Capsule())

                Spacer()
            }.padding()
        }.padding()//.background(Constants.CustomColors.colorAppGrey)
            .padding(.top, 20)
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(showToast: .constant(false), hidePopUp: .constant(false), toastMsg: .constant(""))
    }
}
