//
//  MyProfilePageView.swift
//  KFECinemas
//
//  Created by MAC on 01/07/22.
//

import SwiftUI

struct MyProfilePageView: View {
    @State private var mobileNumber: String = ""
    @State private var emailId : String = ""
    @State private var userName : String = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var disableTextField = true
    
    @State private var editBtnName : String = "Edit"
    @State var errorPopup : Bool? = false
    @State var toastMsg : String = "Not valid"
    @ObservedObject var viewModel = UserAuthModel()
    @EnvironmentObject var storageSettings:StorageSettings

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack( spacing: 15){
                    ZStack{
                        Text("My Profile")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .accentColor(Color.white)
                        HStack{
                            HStack(alignment: .bottom ){
                                Button{
                                    presentationMode.wrappedValue.dismiss()
                                    
                                }label: {
                                    
                                    
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25.0, height: 25.0)
                                        .foregroundColor(.white)
                                    
                                }
                                Spacer()
                                Button{
                                    if editBtnName == "Edit"{
                                        editBtnName = "Save"
                                        disableTextField = false
                                    }else{
                                        if mobileNumber != "" && emailId != "" && userName != ""{
                                            viewModel.updateProfileApi(name : userName , mobileNumber : mobileNumber , email :emailId) { result in
                                                storageSettings.userName = userName
                                                storageSettings.emailAddress = emailId
                                                storageSettings.mobileNumber = mobileNumber
                                                errorPopup = true
                                                toastMsg = "Profile updated sucessfully"
                                                editBtnName = "Edit"
                                                disableTextField = true
                                            }
                                        }else{
                                            errorPopup = true
                                            toastMsg = "Please fill all fields"
                                        }
                                    }
                                }label: {
                                    Text(editBtnName)
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(nil)
                                        .accentColor(Color.white)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 30, leading: 10, bottom: 20, trailing: 20))
                    .frame(minWidth: geometry.size.width,maxHeight: 60)
                    .background(Color.red)
                    Image("pro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height:100 )
                        .clipShape(Circle())
                        .padding(20)
                    VStack{
                        HStack{
                            Text("User Name")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white).opacity(0.7)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal , 15)
                            Spacer()
                        }
                        
                        
                        TextField("", text: $userName)
                            .disabled(disableTextField)
                            .placeholder(when: userName.isEmpty) {
                                Text("Enter your Name").foregroundColor(.white).opacity(0.4)
                            }.accentColor(Color.white).foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    }                            //.frame(maxWidth : .infinity)
                    VStack{
                        HStack{
                            Text("Mobile Number")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white).opacity(0.7)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal , 15)
                            Spacer()
                        }
                        TextField("", text: $mobileNumber)
                            .disabled(disableTextField)
                            .placeholder(when: mobileNumber.isEmpty) {
                                Text("Enter your Mobile Number").foregroundColor(.white).opacity(0.4)
                            }.accentColor(Color.white).foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    }
                    VStack{
                        HStack{
                            Text("Email id")
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                                .foregroundColor(.white).opacity(0.7)
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal , 15)
                            Spacer()
                        }
                        TextField("", text: $emailId)
                            .disabled(disableTextField)
                            .placeholder(when: emailId.isEmpty) {
                                Text("Enter your Email").foregroundColor(.white).opacity(0.4)
                            }.accentColor(Color.white).foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    }
                }.frame( maxWidth: .infinity)
                
                    .navigationBarHidden(true)
            }
        }.background(Color.black)
            .onAppear(){
                viewModel.viewProfileApi { result in
                    mobileNumber = result.data?.mbleNum ?? ""
                    userName = result.data?.userName ?? ""
                    emailId = result.data?.email ?? ""
                }
            }
            .toast(isShowing: $errorPopup,textContent: toastMsg)
        
    }
}

struct MyProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfilePageView()
    }
}
