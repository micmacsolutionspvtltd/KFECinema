//
//  SignupView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/03/22.
//

import SwiftUI

struct SignupView: View {
    @State private var mobileNumber: String = ""
    @State private var userName: String = ""
    @State private var emailId: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword = false
    @State private var confirmPasswordShow = false
    @State var loginType : String = "1"
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode> 
    @EnvironmentObject var viewModel: UserAuthModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack{
                    Image("batne").resizable().scaledToFill()
                    Image("kfelogo").resizable().frame(width: 100, height: 60).offset(y: -100)
                    VStack {
                        TextField("", text: $userName)
                          //  .keyboardType(.numberPad)
                           // .disableAutocorrection(false)
                            .placeholder(when: userName.isEmpty) {
                                Text("Enter your Name").foregroundColor(.white).opacity(0.4)
                        }.foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        
//                      
                        TextField("", text: $mobileNumber)
                            .keyboardType(.numberPad)
                            .placeholder(when: mobileNumber.isEmpty) {
                                Text("Enter your mobile number").foregroundColor(.white).opacity(0.4)
                        }.foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        
//
                        TextField("", text: $emailId)
                           // .keyboardType(.numberPad)
                            .placeholder(when: emailId.isEmpty) {
                                Text("Enter your Email").foregroundColor(.white).opacity(0.4)
                        }.foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))

                        HStack {
                            if showPassword{
                                TextField("", text: $password)
                                  //  .keyboardType(.numberPad)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                }.foregroundColor(.white)
                               // TextField("Enter your password", text: $password)
                                
                            }else{
                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                    }.foregroundColor(.white)
                               // SecureField("Enter your password", text: $password)
                                
                            }
                            Button(action:{
                                if showPassword == false{
                                    showPassword = true
                                }else{
                                    showPassword = false
                                }
                            }){
                                
                                Image(systemName: showPassword ? "eye" : "eye.slash").background(Color("ColorAppGrey"))

                                
                                
                            }
                            
                        }.padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        HStack {
                            if confirmPasswordShow{
                               // TextField("Confirm your password", text: $confirmPassword)
                                TextField("", text: $confirmPassword)
                                   // .keyboardType(.numberPad)
                                    .placeholder(when: confirmPassword.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                }.foregroundColor(.white)
                            }else{
                              //  SecureField("Confirm your password", text: $confirmPassword)
                                SecureField("", text: $confirmPassword)
                                    .placeholder(when: confirmPassword.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                    }.foregroundColor(.white)
                            }
                            Button(action:{
                                if confirmPasswordShow == false{
                                    confirmPasswordShow = true
                                }else{
                                    confirmPasswordShow = false
                                }
                            }){
                                
                                Image(systemName: confirmPasswordShow ? "eye" : "eye.slash").background(Color("ColorAppGrey"))
                                
                                
                            }
                            
                        }.padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    }
                    
                    Button(action: {
                        viewModel.signUpApi(mobno: mobileNumber, emailId: emailId, password: password, name: userName, loginMethod: "1") { result in
                            if result.status == 1{
                                self.presentationMode.wrappedValue.dismiss()
                                //  moveNextPage = true
                            }
                        }
                    }) {
                        Text("CREATE ACCOUNT")
                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                            .frame(minWidth: geometry.size.width * 0.9)
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .cornerRadius(.infinity)
                    }.padding(.top , 15.0)
                    
                    Text("OR").font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                }
                Button(action: {
                    viewModel.signIn(completionHandler:{ result in
                        emailId = result.profile?.email ?? ""
                        userName = result.profile?.name ?? ""
                        loginType = "2"
                    })
                    //  SocialLogin.attemptLoginGoogle()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("Continue With")
                           // .foregroundColor(.black)
                        //  .padding(.trailing, 10.0)
                        Spacer()
                        Image("google")
                            .padding(.leading, 10.0)
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .frame(minWidth: geometry.size.width * 0.9)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                }
                .background(Color("ColorAppGrey"))
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 2, trailing: 15))
                
                Button(action: {
                    viewModel.facebookLogin()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("Continue With")
                            
                        //  .padding(.trailing, 10.0)
                        Spacer()
                        Image("facebook")
                            .padding(.leading, 10.0)
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .frame(minWidth: geometry.size.width * 0.9)
                    .foregroundColor(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                }
                .background(Color("ColorAppGrey"))
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15))
                VStack(alignment: .center, spacing: 15.0){
                    HStack{
                        Text("Already Have an account? ").foregroundColor(Color.gray)
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        }) {
                            Text("Sign In").fontWeight(.bold).foregroundColor(Color.red)
                            
                        }
                    }.padding(.horizontal)
                }.padding(.bottom, 40.0)
            }.background(Color.black)
            
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
