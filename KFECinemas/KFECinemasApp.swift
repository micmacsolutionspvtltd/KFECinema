//
//  KFECinemasApp.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 12/02/22.
//

import SwiftUI
import GoogleSignIn
import FBSDKCoreKit

@available(iOS 14.0, *)
@main
struct KFECinemasApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
 
        WindowGroup {
            LoginView().environmentObject(LoginView_Previews.order)
//            if StorageManager.sharedInstance.getLoginCompleted() == true{
//               // NavigationView{
//                    LoginView().environmentObject(LoginView_Previews.order)
//               // }
//
//            }else{
//                NavigationView{
//                    Dashboard()
//                }
//            }
           
        }
    }
}
class AppDelegate : NSObject , UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Settings.shared.appID = "fb636968437734329"
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if(url.scheme!.isEqual("fb636968437734329")) {
            return ApplicationDelegate.shared.application(app, open: url, options: options)
        }else{
        return GIDSignIn.sharedInstance.handle(url)
        }
        
    }
}
