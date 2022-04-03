//
//  RequestGenerator.swift
//  Fustionkitchen
//
//  Created by Macintosh HDD on 05/10/21.
//  Copyright © 2021 fusionpos. All rights reserved.
//

import UIKit

class RequestGenerator: NSObject {
    static let sharedInstance = RequestGenerator()
    
    func generateURLRequest(urlValue: String, requestBody: [String:Any]? = [:]) throws -> URLRequest {
        print("URL = ",urlValue)
        var requestBodyValue:Data? = nil
        print("Parameter = ",requestBody ?? ["":""])
        if let requestBodyVal = requestBody {
            let json = try JSONSerialization.data(withJSONObject: requestBodyVal, options: [])
            requestBodyValue = json
        }
     
        var urlRequest = URLRequest(url: URL(string : urlValue)!)
        urlRequest.httpBody = requestBodyValue
   //     urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        return urlRequest
    }
}
