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
    @Environment(\.presentationMode) var presentationMode
    @State var moveNextPage : Bool = false
    @EnvironmentObject var viewModel: UserAuthModel

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack{
                    Image("batne").resizable().scaledToFill()
                    Image("kfelogo").resizable().frame(width: 100, height: 60).offset(y: -100)
                    VStack {
                        TextField("Enter your Name", text: $userName)
                            .foregroundColor(Color.white)
                            .padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        TextField("Enter your mobile number", text: $mobileNumber).foregroundColor(Color.white).padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        TextField("Enter your Email", text: $emailId).foregroundColor(Color.white).padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        HStack {
                            if showPassword{
                                TextField("Enter your password", text: $password)
                                
                            }else{
                                SecureField("Enter your password", text: $password)
                                
                            }
                            Button(action:{
                                if showPassword == false{
                                    showPassword = true
                                }else{
                                    showPassword = false
                                }
                            }){
                                
                                Image(systemName: showPassword ? "eye" : "eye.slash").background(Color.gray)
                                
                                
                            }
                            
                        }.padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        HStack {
                            if showPassword{
                                TextField("Confirm your password", text: $confirmPassword)
                                
                            }else{
                                SecureField("Confirm your password", text: $confirmPassword)
                                
                            }
                            Button(action:{
                                if confirmPasswordShow == false{
                                    confirmPasswordShow = true
                                }else{
                                    confirmPasswordShow = false
                                }
                            }){
                                
                                Image(systemName: confirmPasswordShow ? "eye" : "eye.slash").background(Color.gray)
                                
                                
                            }
                            
                        }.padding().background(Color.gray).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
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
                    viewModel.signIn()
                  //  SocialLogin.attemptLoginGoogle()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("Continue With")
                            .foregroundColor(.black)
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
                .background(Color.gray)
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 2, trailing: 15))
                
                Button(action: {
                    viewModel.facebookLogin()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("Continue With")
                            .foregroundColor(.black)
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
                .background(Color.gray)
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15))
           // }
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
        NavigationLink(destination: LoginView(), isActive: $moveNextPage){
       
                       }
        
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
