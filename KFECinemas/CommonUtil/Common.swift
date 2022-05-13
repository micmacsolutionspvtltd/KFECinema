//
//  Common.swift
//  Basispay QR
//
//  Created by Apple on 27/01/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import AVKit

typealias CompletionBlock = (String, String) -> Void
typealias pincode = String
typealias latitude = String
typealias longitude = String
typealias city = String
typealias address = String
typealias placeName = String
class Common {
    
    
    // MARK: - Class Methods
    static let sharedInstance = Common()
  
    private init() {
        
       
        
    }
    
    //MARK: - Common Details
    
    func getDefaultHistoryDate()->(String,String) {
        let today = Date()
        let thirtyDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -30, to: today)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let fromDate = formatter.string(from: thirtyDaysBeforeToday)
        let toDate = formatter.string(from: today)
        
        return (fromDate,toDate)
    }
    
    func getDefaultDate()->(String,String) {
        
        let today = Date()
        let thirtyDaysBeforeToday = Calendar.current.date(byAdding: .day, value: -30, to: today)!
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let fromDate = formatter.string(from: thirtyDaysBeforeToday)
        let toDate = formatter.string(from: today)
        return (fromDate,toDate)
    }
    
    func animateTable(tableView:UITableView) {
        
        tableView.reloadData()
    let cells = tableView.visibleCells
    
    let tableViewHeight = tableView.bounds.size.height
    
    for cell in cells {
        cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
    }
    
    var delayCounter = 0
    for cell in cells {
        UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
            }, completion: nil)
        delayCounter += 1
    }
        
    
}
    

    
//    func getMobileNumber()->String {
//        guard let userDetails = StorageManager.sharedInstance.fetchUserDetails()  else {
//            return ""
//        }
//
//        if Constants.isTestingEnabled {
//            return "8248350384"
//        }else {
//            guard let id = userDetails[Constants.UserDetailsKeys.mobileNumber] as? String else {
//                return ""
//            }
//            return id
//        }
//    }
//
//    func getAccessToken()->String {
//         guard let userDetails = StorageManager.sharedInstance.fetchUserDetails()  else {
//             return ""
//         }
//
//        if let merchantId = userDetails[Constants.UserDetailsKeys.accessToken] as? String  {
//            return merchantId
//        }
//
//        return ""
//    }
//
//   func getUserName()->String {
//        guard let userDetails = StorageManager.sharedInstance.fetchUserDetails()  else {
//            return ""
//        }
//       return userDetails[Constants.UserDetailsKeys.userName] as! String
//   }
//
//
////    func updateUserLocation(locationDetails:[String:Any],onCompletion:@escaping (Bool,AddressModel?,Error?)->Void){
//        let urlRequest = (try? RequestGenerator.sharedInstance.generateURLRequest(endpoint: .updateUserLocation,requestBody : locationDetails))!
//        NetworkManager.sharedInstance.processRequest(request: urlRequest, responseType: AddressModel.self) { (success, response, error) in
//            guard success, error == nil, let progressResponse = response else {
//                onCompletion(false, response,error)
//                return
//            }
//            do {
//                onCompletion(true, progressResponse,error)
//            } catch {
//                print("somthing error ")
//                onCompletion(false, response,error)
//            }
//        }
//      }
////
//    func getAutoCompleteAddress(placeId:String,onCompletion:@escaping(Bool,placeName?,address?,city?,pincode?)->Void) {
//        GooglePlacesAPI.GooglePlaces.provide(apiKey: Constants.mapApiKey)
//        GooglePlacesAPI.GooglePlaces.placeDetails(forPlaceID: placeId, language: "en_US") { (response, error) -> Void in
//
//            guard let place = response?.result, response?.status == GooglePlaces.StatusCode.ok else {
//                onCompletion(false,nil,nil,nil,nil)
//                return
//            }
//
//
//            let city = place.addressComponents.first(where: { $0.types.first == "locality" })?.longName
//            let pincode = place.addressComponents.first(where: { $0.types.first == "postal_code" })?.longName
//            onCompletion(true,place.name,place.formattedAddress,city,pincode)
//
//        }
//    }
    
    
    

//    func getImage(imageView:UIImageView,urlString:String){
//        var imageCache = ImageCache.getImageCache()
//        if let cacheImage = imageCache.get(forKey: urlString) {
//            imageView.image = cacheImage
//            return
//        }
//         RequestGenerator.sharedInstance.getDocumentsFromUrlString(endpoint: .getImageAssets, urlString: urlString) { (result, dataVal, error) in
//            if result {
//             guard let value = dataVal else {
//                 return
//             }
////            guard let cacheImage = imageCache.get(forKey: urlString) else {
////                 return
////            }
//             DispatchQueue.main.async {
//                guard let loadedImage = UIImage(data: value) else {
//                    return
//                }
//
//                imageCache.set(forKey: urlString, image: loadedImage)
//                imageView.image = loadedImage
//
//             }
//            }
//        }
//
//     }
//
//    func getProductImage(urlString:String,onCompletion:@escaping(Bool,UIImage?)->Void){
//        let imageCache = ImageCache.getImageCache()
//
//        if let cacheImage = imageCache.get(forKey: urlString) {
//            onCompletion(true,cacheImage)
//            return
//        }
//         RequestGenerator.sharedInstance.getDocumentsFromUrlString(endpoint: .getImageAssets, urlString: urlString) { (result, dataVal, error) in
//            if result {
//             guard let value = dataVal else {
//                 return
//             }
//             DispatchQueue.main.async {
//                guard let loadedImage = UIImage(data: value) else {
//                    return
//                }
//
//                imageCache.set(forKey: urlString, image: loadedImage)
//                onCompletion(true, loadedImage)
//             }
//            }else {
//                onCompletion(false,nil)
//            }
//        }
//
//     }
//

    func randomString(length: Int) -> String {
      let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func clearAllUserDefaults(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
     // MARK: - Validations
    
    func isValidUserName(userName:String?) -> Bool {
        let alphaNumericSet=CharacterSet(charactersIn: Constants.CharacterSet.Alphabets)
        let output: String = userName!.trimmingCharacters(in: alphaNumericSet.inverted)
        let isValid: Bool = (userName == output)
        return isValid
    }
    
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else {
            return false
        }
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
    
    func isValidMobile(mobile:String?) -> Bool {
        let mobileSet = CharacterSet(charactersIn: Constants.CharacterSet.MobileCharacters)
        let output: String = mobile!.trimmingCharacters(in: mobileSet.inverted)
        let isValid: Bool = (mobile == output)
        return isValid
    }
    
    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else {
            return false
        }
        let regEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%!+&])(?=\\S+$).{8,15}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return passwordTest.evaluate(with: testStr)
    }
    
    func checkLength(maxLength:Int,text:String,range: NSRange,replaceString:String)->Bool{
        let currentString:NSString = text as NSString
        let newString:NSString =
            currentString.replacingCharacters(in: range, with: replaceString) as NSString

        return newString.length <= maxLength
    }
    
    func alertAnimation(view:UIView,blackLayer:UIView){
        blackLayer.isHidden = false
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
         view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func dismissAlertAnimation(view:UIView,blackLayer:UIView,completionHandler:@escaping(Bool)->Void){
       
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                  blackLayer.isHidden = true
//                    view.isHidden = true
                    }, completion: completionHandler)
    }
//    
//    func getRootViewController()-> UIViewController? {
//        if let app = UIApplication.shared.delegate as? SceneDelegate, let window = app.window {
//            return window.rootViewController
//        }else {
//            return nil
//        }
//    }
    
    
    func isUpdateAvailable() throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw NetworkError.badRequest
        }
        let data = try Data(contentsOf: url)
        guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
            throw NetworkError.noInternetAccess
        }
        if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
          
            return Float(version)! > Float(currentVersion)!
        }
        throw NetworkError.unAuthorised
    }
    

        func popupUpdateDialogue(parentView: UIViewController){
            let versionInfo = Constants.AppVersion
            let alertMessage = "A new version of Basispay Qr Application is available,Please update to version " + versionInfo;
            let alert = UIAlertController(title: "New Version Available", message: alertMessage, preferredStyle: UIAlertController.Style.alert)

            let okBtn = UIAlertAction(title: "Update", style: .default, handler: {(_ action: UIAlertAction) -> Void in
                if let url = URL(string: Constants.WebViewType.appStore),
                    UIApplication.shared.canOpenURL(url){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            let noBtn = UIAlertAction(title:"Skip this Version" , style: .destructive, handler: {(_ action: UIAlertAction) -> Void in
            })
            alert.addAction(okBtn)
            alert.addAction(noBtn)
            parentView.present(alert, animated: true, completion: nil)

        }
    
    func sessionExpiredPopup(parentView: UIViewController,message:String,submitClicked:@escaping ()->Void){
        let alertMessage = message;
        let alert = UIAlertController(title: "Session Expired", message: alertMessage, preferredStyle: UIAlertController.Style.alert)

        let okBtn = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            submitClicked()
        })
    
        alert.addAction(okBtn)
        parentView.present(alert, animated: true, completion: nil)

    }
    
    // MARK: - Alert Methods
    func displayAlertMessage(parentView: UIViewController, title: String, message: String, buttonTitle: String, buttonAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: buttonAction))
        parentView.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertMessage(parentView: UIViewController, title: String, message: String, primaryButtonTitle: String, primaryButtonAction: ((UIAlertAction) -> Void)?, secondaryButtonTitle: String, secondaryButtonAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryButtonTitle, style: .cancel, handler: primaryButtonAction))
        alert.addAction(UIAlertAction(title: secondaryButtonTitle, style: .default, handler: secondaryButtonAction))
        parentView.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertMessageForImageView(parentView: UIViewController, title: String, message: String, primaryButtonTitle: String, primaryButtonAction: ((UIAlertAction) -> Void)?, secondaryButtonTitle: String, secondaryButtonAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: primaryButtonTitle, style: .default, handler: primaryButtonAction))
        alert.addAction(UIAlertAction(title: secondaryButtonTitle, style: .default, handler: secondaryButtonAction))
        alert.addAction(UIAlertAction(title: Constants.AlertButton.Cancel, style: .cancel, handler: nil))
        parentView.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Round Off Methods
    func getRoundedToTwoDigits(value: Double) -> String {
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let value = ceil(value * multiplier) / multiplier
        return String(format: "%.2f", value)
    }
    
    func getRoundedToFourDigits(value: Double) -> String {
        let numberOfPlaces = 4.0
        let multiplier = pow(10.0, numberOfPlaces)
        let value = ceil(value * multiplier) / multiplier
        return String(format: "%.4f", value)
    }

    
    // MARK: - Date Formatter Methods
    func getCurrentMonth() -> (String, String) {
        let currentDate = Date()
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = Constants.DateFormat.ThreeLetterMonthFormat
        let currentMonth = monthFormatter.string(from: currentDate)
        let monthNumberFormatter = DateFormatter()
        monthNumberFormatter.dateFormat = Constants.DateFormat.TwoLetterMonthFormat
        let currentNumberMonth = monthNumberFormatter.string(from: currentDate)
        return (currentMonth, currentNumberMonth)
    }
    
     func getCurrentYear() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.YearFormat
        let currentYear = dateFormatter.string(from: Date())
        return currentYear
    }
    
    func getLongDateFormatFromDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.UTCDateFormat

        let dt = dateFormatter.date(from: dateString)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = Constants.DateFormat.LongDateTimeFormat
        dateFormatter.timeZone = TimeZone.current
        let convertedDate = dateFormatter.string(from: dt!)
        return convertedDate
    }
    
    func getDateFormatFromDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.LongDateTimeFormat

        let dt = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = Constants.DateFormat.normalDateFormat
        dateFormatter.timeZone = TimeZone.current
        let convertedDate = dateFormatter.string(from: dt!)
        return convertedDate
    }
    
    func getTimeFormatFromDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.UTCDateFormat

        let dt = dateFormatter.date(from: dateString)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = Constants.DateFormat.TimeFormat
        dateFormatter.timeZone = TimeZone.current
        let convertedDate = dateFormatter.string(from: dt!)
        return convertedDate
    }
    
    func getShowTime(time: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.TimeFormat2
        let dt = dateFormatter.date(from: time)
        dateFormatter.dateFormat = Constants.DateFormat.TimeFormat
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: dt!)
    }
    
    // MARK: - Loading View Rotate Method
    func rotateView(targetView: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotateView(targetView: targetView, duration: duration)
        }
    }
    
    func setCustomeLabelProperties(font:UIFont? = nil,label:UILabel,color:UIColor? = nil,text:String? = nil){
        label.font = font
        label.textColor = color
        label.text = text
    }
    
    func setCustomButtonProperties(font:UIFont? = nil,button:UIButton,color:UIColor? = nil,text:String? = nil){
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = font
        button.setTitleColor(color, for: .normal)
    }
    
    
    
}

