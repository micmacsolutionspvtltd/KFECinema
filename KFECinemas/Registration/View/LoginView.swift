//
//  LoginView.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/02/22.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @State private var mobileNumber: String = ""
    @State private var password: String = ""
    @State private var showPassword = false
    @State var moveDashBoardPage : Bool = false
    @EnvironmentObject var viewModel: UserAuthModel
   
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
            ScrollView {
                VStack{
                    Image("batne").resizable().scaledToFill()
                    Image("kfelogo").resizable().frame(width: 100, height: 60).offset(y: -100)
                    VStack {
                        TextField("", text: $mobileNumber)
                            .placeholder(when: mobileNumber.isEmpty) {
                                Text("Enter your Mobile Number").foregroundColor(.white).opacity(0.4)
                        }.foregroundColor(Color.white).padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                        
                        HStack {
                            if showPassword{
                                TextField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                
                            }
                            }else{
                                SecureField("", text: $password)
                                    .placeholder(when: password.isEmpty) {
                                        Text("Enter your password").foregroundColor(.white).opacity(0.4)
                                    }
//                                SecureField("Enter your password", text: $password)
                                
                            }
                            Button(action:{
                                if showPassword == false{
                                    showPassword = true
                                }else{
                                    showPassword = false
                                }
                            }){
                                
                                Image(systemName: showPassword ? "eye" : "eye.slash").foregroundColor(.gray).background(Color("ColorAppGrey"))
                            }
                            
                        }.padding().background(Color("ColorAppGrey")).cornerRadius(5).padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    }
                    Button{
                        viewModel.loginApi(mobno: mobileNumber, password: password, loginMethod: "1") { result in
                            if result.status == 1{
                                StorageManager.sharedInstance.setLoginCompleted(state: true)
                                StorageManager.sharedInstance.storeUserId(id: result.data?[0].id ?? "")
                                moveDashBoardPage = true
                            }else{
                                
                            }
                        }
                    }label: {
                        Text("SIGNIN")
                                .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                                .frame(minWidth: geometry.size.width * 0.9)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .cornerRadius(.infinity)
                    }.padding(.top , 15.0)
//                    NavigationLink(destination: Dashboard()){
//                    Text("SIGNIN")
//                            .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
//                            .frame(minWidth: geometry.size.width * 0.9)
//                            .foregroundColor(Color.white)
//                            .background(Color.red)
//                            .cornerRadius(.infinity)
//                    }.padding(.top , 15.0)
                    
                    Text("OR").font(.system(size: 25)).fontWeight(.bold).foregroundColor(Color.white)
                }
                Button(action: {
                    viewModel.signIn()
                    print(viewModel.givenName)
                  //  SocialLogin.attemptLoginGoogle()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("CONTINUE WITH").font(.footnote)
                            .foregroundColor(.white)
                        //  .padding(.trailing, 10.0)
                        Spacer()
                        Image("google")
                            .padding(.leading, 10.0)
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .frame(minWidth: geometry.size.width * 0.9)
                    .foregroundColor(Color.white).background(Color("ColorAppGrey"))
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                }
                
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 2, trailing: 15))
                
                Button(action: {
                    viewModel.facebookLogin()
                }) {
                    HStack(alignment: .center, spacing: 5.0) {
                        Spacer()
                        Text("CONTINUE WITH").font(.footnote)
                            .foregroundColor(.white)
                        //  .padding(.trailing, 10.0)
                        Spacer()
                        Image("facebook")
                            .padding(.leading, 10.0)
                    }
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .frame(minWidth: geometry.size.width * 0.9)
                    .foregroundColor(Color.white).background(Color("ColorAppGrey"))
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(Color.red, lineWidth: 2)
                    )
                    
                }
                .cornerRadius(.infinity)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 20, trailing: 15))
           // }
                VStack(alignment: .center, spacing: 25){
                    HStack{
                        Text("New to KFE cinemas? ").font(.system(size: 15)).foregroundColor(Color.gray)
                       
                        NavigationLink(destination: SignupView()) {
                            Text("Create Account").font(.system(size: 15)).fontWeight(.bold).foregroundColor(Color.red)
                                }
                    }.padding(.horizontal)
                    HStack{
                        Text("Forgot Password?").font(.system(size: 15)).foregroundColor(Color.gray)
                        Text("Click Here").font(.system(size: 15)).fontWeight(.bold).foregroundColor(Color.red)
                    }.padding(.horizontal)
                }.padding(.bottom, 30.0)
            }.background(Color.black)
                    .navigationBarHidden(true)
                NavigationLink(destination: Dashboard(), isActive: $moveDashBoardPage){
                    Dashboard()
                }
        }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static let order = UserAuthModel()
    static var previews: some View {
        LoginView().environmentObject(order)

    }
}


struct GoogleSignInBtn: UIViewRepresentable {
    var userData: UserAuthModel
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    typealias UIViewType = GIDSignInButton
    
    init(_ userData: UserAuthModel) {
        self.userData = userData
    }

    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        
        switch colorScheme {
        case .light:
            button.colorScheme = .light
        case .dark:
            button.colorScheme = .dark
        default:
            button.colorScheme = .light
        }
        
        if #available(iOS 14.0, *) {
            button.addAction(.init(handler: { _ in
                guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
                
                //            GIDSignIn.sharedInstance.signIn(
                //                with: self.userData.signIn(),
                //                presenting: presentingViewController,
                //                callback: { user, error in
                //                    if let error = error {
                //                        print("error: \(error.localizedDescription)")
                //                    }
                //                    else if let user = user {
                //                        self.userData.signIn(user: user)
                //                    }
                //                })
            }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        button.isEnabled = false
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
    }
    
}
