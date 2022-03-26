//
//  Util.swift
//  Basispay QR
//
//  Created by Saravanan on 14/08/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit

class Util: NSObject {
    
    static let shared = Util()
    
    func getValueFromInfoDict(key: String) -> String? {
        let dictionary = Bundle.main.infoDictionary!
        return dictionary[key] as? String
    }
    
    func authHeader(username:String,password:String)->String{
        let username = username
        let password = password
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
      func convertDateFormater(_ date: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            var dateValue = dateFormatter.date(from: date)
            if date == nil{
               dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
               dateValue = dateFormatter.date(from: date)
            }
            dateFormatter.dateFormat = "dd MMM yyyy"
            if dateValue == nil {
                return ""
            }
            return  dateFormatter.string(from: dateValue!)

        }
     func stringFromDate(date: Date, format: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
    //        dateFormatter.timeZone = NSTimeZone.local
    //        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let convertedString = dateFormatter.string(from: date)
            return convertedString
        }

     func alertAnimation(view:UIView,blackLayer:UIView){
        blackLayer.isHidden = false
        view.transform = CGAffineTransform(scaleX: 0, y: 0)
        view.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
         view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}

