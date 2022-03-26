//
//  SKViewController.swift
//  SKGroup
//
//  Created by Naveen Kumar on 29/12/20.
//

import UIKit
import Network
import LocalAuthentication

class GTViewController: UIViewController {
    
    
    override func viewDidLoad() {
        updateIfAppVersionChanges()
        monitorStatus()
    }
    
    func updateIfAppVersionChanges(){
        DispatchQueue.global().async {
                    do {
                        let update = try Common.sharedInstance.isUpdateAvailable()
                        DispatchQueue.main.async {
                            if update{
                                Common.sharedInstance.popupUpdateDialogue(parentView: self)
                            }else {
                                
                            }
                            
                        }
                    } catch {
                        print(error)
                    }
                }
    }
    
    func showLoader(){
      ///  HUD.sharedInstance.displayLoadingHud(view: self.view)
    }
    
    func stopLoader(){
      ///  HUD.sharedInstance.hideHud(fromView: self.view)
    }
    
    func monitorStatus(){
        if #available(iOS 12.0, *) {
            let monitor = NWPathMonitor()
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    print("We're connected!")
                } else {
                    DispatchQueue.main.async {
                        Common.sharedInstance.displayAlertMessage(parentView: self, title: "No Internet" , message: "Kindly connect to network connection to proceed further", buttonTitle: "Settings") { _ in
                            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                                return
                            }
                            
                            if UIApplication.shared.canOpenURL(settingsUrl) {
                                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                    print("Settings opened: \(success)") // Prints true
                                })
                            }
                        }
                    }
                }

                print(path.isExpensive)
            }
            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
        }
         else {
           if NetworkManager.sharedInstance.isConnectedToNetwork {
                print("We're connected!")
            }else {
                DispatchQueue.main.async {
                    Common.sharedInstance.displayAlertMessage(parentView: self, title: "No Internet" , message: "Kindly connect to network connection to proceed further", buttonTitle: "Settings") { _ in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                            return
                        }
                        
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                print("Settings opened: \(success)") // Prints true
                            })
                        }
                    }
                }
            }
           
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Subscribe for Foreground background events
        NotificationCenter.default.addObserver(self, selector: #selector(GTViewController.applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GTViewController.applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc
    func applicationDidEnterBackground() {
      
        //Override in subclasses if necessary
    }
    
    @objc
    func applicationWillEnterForeground() {
        //Override in subclasses if necessary
           
    }
    
    func handleNotification() {
        // Handle Notification appropriate for the view controller in specific child
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
