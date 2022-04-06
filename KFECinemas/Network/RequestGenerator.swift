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
    
    func generateURLRequest(urlValue: String, requestBody: [String:String]? = [:],queryItem:[URLQueryItem]? = []) throws -> URLRequest {
        print("URL = ",urlValue)
        var requestBodyValue:[URLQueryItem] = []
        print("Parameter = ",requestBody ?? ["":""])
        if let requestBodyVal = requestBody {
            for value in requestBodyVal {
                requestBodyValue.append(URLQueryItem(name: value.key, value: value.value))
            }

        }
        print(requestBodyValue)
       var urlComponents = URLComponents(string: urlValue)
        urlComponents?.queryItems = requestBodyValue
     
        var urlRequest = URLRequest(url: urlComponents!.url!)
      

//        urlRequest.httpBody = requestBodyValue
        urlRequest.setValue("text/html; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        return urlRequest
    }
}
