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
    
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    let loginManager = LoginManager()

    
    init(){
        check()
    }
    
    func checkStatus(){
        if(GIDSignIn.sharedInstance.currentUser != nil){
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }
            let clientId = user.userID
            let givenName = user.profile?.givenName
            let profilePicUrl = user.profile!.imageURL(withDimension: 100)!.absoluteString
            self.givenName = givenName ?? ""
            self.profilePicUrl = profilePicUrl
            self.isLoggedIn = true
        }else{
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
            self.profilePicUrl =  ""
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
    
    func signIn(){
        
       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: "371242278405-pqqnrmm748gm6uggf0lc0ssbkbkelo2f.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController,
            callback: { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                self.checkStatus()
            }
        )
    }
    
    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
    func facebookLogin() {
        Settings.shared.appID = "636968437734329"
           loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
               switch loginResult {
               case .failed(let error):
                   print(error)
               case .cancelled:
                   print("User cancelled login.")
               case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                   print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
//                   GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
//                       if (error == nil){
//                           let fbDetails = result as! NSDictionary
//                           print(fbDetails)
//                       }
//                   })
               }
           }
    }
    
    
       
}
    class FBLogin: LoginManager {

        let loginButton = FBLoginButton()
        let token = AccessToken.current
        let permissions = ["user_birthday", "user_gender", "public_profile"]

        override init(){
            super.init()
            logIn(permissions: permissions, from: nil)
            print("fb init()")
        }

        override func logIn(permissions: [String], from fromViewController: UIViewController?, handler: LoginManagerLoginResultBlock? = nil) {
            // TODO
        }

    }
