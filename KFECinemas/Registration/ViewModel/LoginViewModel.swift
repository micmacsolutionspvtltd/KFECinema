//
//  LoginViewModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/02/22.
//
import SwiftUI
import GoogleSignIn
import FBSDKLoginKit

class UserAuthModel: ObservableObject {
    
    @Published var getSignUpData : SignUpDataModel?
    @Published var givenName: String = ""
    @Published var email: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var loginId :  String = ""
   

    
    init(){
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
 
            self.givenName = user.profile?.name ?? ""
            self.email = user.profile?.email ?? ""
            self.loginId = user.userID ?? ""
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
          //  self.profilePicUrl =  ""
        }
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            
            self.checkStatus()
        }
    }
    
    func signIn(completionHandler : @escaping (GIDGoogleUser) -> Void){
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: "371242278405-pqqnrmm748gm6uggf0lc0ssbkbkelo2f.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController) { user, error in
                if let error = error {
                       self.errorMessage = "error: \(error.localizedDescription)"
                   }
                   if(GIDSignIn.sharedInstance.currentUser != nil){
                       let user = GIDSignIn.sharedInstance.currentUser
                       guard let user = user else { return }
   
                       self.givenName = user.profile?.name ?? ""
                       self.email = user.profile?.email ?? ""
                       self.loginId = user.userID ?? ""
                       self.isLoggedIn = true
                       completionHandler(user)
                   }else{
                       self.isLoggedIn = false
                       self.givenName = "Not Logged In"
                     //  self.profilePicUrl =  ""
                   }
   
               }
            

    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
    func facebookLogin() {
        let loginManager = LoginManager()
        Settings.shared.appID = "1312073875795599"
        
//        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
//                  switch loginResult {
//                  case .failed(let error):
//                      print(error)
//                  case .cancelled:
//                      print("User cancelled login.")
//                  case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                      print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
//                      GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
//                          if (error == nil){
//                              let fbDetails = result as! NSDictionary
//                              print(fbDetails)
//                          }
//                      })
//                  }
//              }
        
    }
    
    func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String , completionHandler : @escaping((SignUpDataModel) -> Void) ){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        let params : [String : String]?
      params = [
        "mble_num": mobno,
        "email": emailId,
        "password" : password,
        "user_name": name,
        "sign_up_type" : loginMethod
      ]
       
        let urlRequest = APIList().getUrlString(url : .SIGNUP)
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue:urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: SignUpDataModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
                self.getSignUpData = result!
                completionHandler(result!)
                   // self.delegate?.diReciveWalletBalance(data: result!)
            }else{
              //  self.delegate?.didFailWithError(error: String(error?.localizedDescription ?? ""))
            }
            }
        }
        
    }
    func loginApi(mobno: String,password :  String , loginMethod : String , completionHandler : @escaping((LoginDataModel) -> Void) ){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        let params : [String : String]?
      params = [
        "mble_num": mobno,
        "password" : password,
        "sign_in_type" : loginMethod
      ]
       
        let urlRequest = APIList().getUrlString(url : .LOGIN)
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: LoginDataModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
                if restValue == true{
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
     
    
    func googleLoginApi(email: String,userName :  String , typeOfLogin : String , completionHandler : @escaping((LoginDataModel) -> Void) ){
  //      func signUpApi(mobno: String,emailId : String,password :  String ,name : String , loginMethod : String){
        let params : [String : String]?
      params = [
        "email": email,
        "user_name" : userName,
        "sign_in_type" : typeOfLogin
      ]
       
        let urlRequest = APIList().getUrlString(url : .LOGIN)
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: LoginDataModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
                if restValue == true{
                    completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
        
    }
    func viewProfileApi(completionHandler : @escaping((ViewProfileModel) -> Void)){
        let urlRequest = APIList().getUrlString(url : .VIEWPROFILE)
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: ["user_id" : StorageSettings().userId]))!
   //     let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.viewProfile ,  requestBody : ["user_id" : StorageSettings().userId]))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: ViewProfileModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                  completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
    }
    func updateProfileApi(name : String , mobileNumber : String , email :String  , completionHandler : @escaping((ForgetPasswordModel) -> Void)){
        let urlRequest = APIList().getUrlString(url : .EDITPROFILE)
        let setRequest = (try?  RequestGenerator.sharedInstance.generateURLRequest(urlValue: urlRequest, requestBody: ["user_id" : StorageSettings().userId , "name" : name , "mobile" : mobileNumber , "mail" : email]))!
     //   let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeThree(endpoint:Endpoint.editProfile ,  requestBody : ["user_id" : StorageSettings().userId , "name" : name , "mobile" : mobileNumber , "mail" : email]))!
        NetWorkManger.sharedInstance.postData(request: setRequest, resultType: ForgetPasswordModel.self) { (restValue, result, error) in
            DispatchQueue.main.async { [unowned self] in
                if restValue == true {
                
                  completionHandler(result!)
                }else{
                    
                }
               
           
            }
        }
    }
}
//    class FBLogin: LoginManager {
//
//        let loginButton = FBLoginButton()
//        let token = AccessToken.current
//        let permissions = ["user_birthday", "user_gender", "public_profile"]
//
//        override init(){
//            super.init()
//            logIn(permissions: permissions, from: nil)
//            print("fb init()")
//        }
//
//        override func logIn(permissions: [String], from fromViewController: UIViewController?, handler: LoginManagerLoginResultBlock? = nil) {
//            // TODO
//        }
//
//    }
