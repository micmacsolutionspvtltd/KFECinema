//
//  ForgetPasswordPopupView.swift
//  KFECinemas
//
//  Created by MAC on 10/05/22.
//

import SwiftUI

struct ForgetPasswordPopupView: View {
    @State var mobileNumber: String = ""
    @Binding var popupShow : Bool?
    @ObservedObject var viewModel = ForgetPasswordViewModel()
    @Binding var errorPopup : Bool?
    @Binding var toastMsg : String
    @State var otpPopUp = false
    var body: some View {
        VStack(spacing : 5){
            Text("Forget password")
                .font(.system(size: 17, weight: .bold)).foregroundColor(.white)
                      
            Text(otpPopUp ? "Please Enter Otp" : "Please enter your existing mobile number")
                .font(.system(size: 17)).foregroundColor(.white)
            TextField("", text: $mobileNumber)
                .placeholder(when: mobileNumber.isEmpty) {
                    Text(otpPopUp ? "OTP (One Time Password)" : "Enter your Mobile Number").foregroundColor(.white).opacity(0.4)
            }.foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
            HStack{
                Button(action: {
                    popupShow = false
                }) {
                  
                        Text("CANCEL").font(.footnote)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.white).background(Color("ColorAppGrey"))
                            .overlay(
                                RoundedRectangle(cornerRadius: .infinity)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                }
                Button{
                    if otpPopUp{
                        if mobileNumber.count == 0{
                            toastMsg = "Please enter valid OTP"
                            errorPopup = true
                            return
                        }
                        viewModel.forgetPasswordOtpSendApi(mobileNUm: mobileNumber, completionHandler: ({ result in
                            if result.reason == ""{
                                
                            }else{
                                toastMsg = result.reason ?? ""
                               errorPopup = true
                            }
                        }))
                    }else{
                    if mobileNumber.count != 10{
                        toastMsg = "Please enter valid mobile number"
                        errorPopup = true
                        return
                    }
                    viewModel.forgetPasswordOtpSendApi(mobileNUm: mobileNumber, completionHandler: ({ result in
                        if result.reason == ""{
                            mobileNumber = ""
                        }else{
                            toastMsg = result.reason ?? ""
                           errorPopup = true
                        }
                    }))
                }
            }label: {
                Text("OK")
                        .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                       // .frame(minWidth: geometry.size.width * 0.9)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .cornerRadius(.infinity)
            }
          
                    
            }.padding(10)
            
        }.padding()
    }
}

struct ForgetPasswordPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordPopupView( popupShow: .constant(false), errorPopup: .constant(false), toastMsg: .constant(""))
            .previewLayout(.fixed(width: 330, height: 280))
            .background(Color.black)
    }
}
