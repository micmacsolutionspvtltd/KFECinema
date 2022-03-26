//
//  RequestGenerator.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import UIKit


class RequestGenerator: NSObject {
    
    private let configurationManager: Configuration = Configuration(rawValue: Util.shared.getValueFromInfoDict(key: Constants.environmentKey )!)!
    static let sharedInstance = RequestGenerator()
    
    func generateURLRequest(endpoint: Endpoint, requestBody: [String:Any]? = nil, queryParams: [URLQueryItem]? = nil, additionalHeader: [String: String]? = nil ,authTokenValue:String? = nil,resourcePath : String? = nil) throws -> URLRequest {
        
        print("==========Request parameters==========\n")
        print(requestBody)
        
        let urlString = endpoint.url(configurationManager)
        
        let urlStringWithPath = urlString + (resourcePath ?? "")
        var urlComponents = URLComponents(string: urlStringWithPath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        urlComponents?.queryItems = queryParams
        
        guard let url = urlComponents?.url else {
            throw NetworkError.unknown(reason: "Unable to generate request")
        }
        
        let protectionSpace = URLProtectionSpace.init(host: configurationManager.baseURL,
                                                      port: 8080,
                                                      protocol: "http",
                                                      realm: nil,
                                                      authenticationMethod: nil)

        
//        let userCredential = URLCredential(user: Constants.Authkeys.username2,
//                                           password: Constants.Authkeys.password2,
//                                           persistence: .permanent)
//
//        URLCredentialStorage.shared.setDefaultCredential(userCredential, for: protectionSpace)
        var requestBodyValue:Data? = nil
        if let requestBodyVal = requestBody {
            let json = try JSONSerialization.data(withJSONObject: requestBodyVal, options: [])
            requestBodyValue = json
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        urlRequest.httpBody = requestBodyValue
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let additionalHeaders = additionalHeader {
            for header in additionalHeaders {
                urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        if let authToken = authTokenValue {
            print("toketn : ",authToken)
            urlRequest.addValue(authToken, forHTTPHeaderField: "access-token")
        }
        
        
//        else {
//            throw NetworkError.unAuthorised
//            }
            
        
        return urlRequest
    }
    
    func generateImageURLRequest(endpoint: Endpoint, requestBody: [String:String]? = nil,image:[Media], additionalHeader: [String: String]? = nil ,authTokenValue:String? = nil,resourcePath : String? = nil) throws -> URLRequest {
        let urlString = endpoint.url(configurationManager)
        
        let urlStringWithPath = urlString + (resourcePath ?? "")
       
        guard let url = URL(string: urlStringWithPath) else { throw NetworkError.badRequest }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod.rawValue
        let boundary = generateBoundary()
        print(requestBody)
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        guard let authToken = authTokenValue else {
            throw NetworkError.unAuthorised
        }
        print("toketn : ",authToken)
        urlRequest.addValue(authToken, forHTTPHeaderField: "Authorization")
        let dataBody = createDataBody(withParameters: requestBody, media: image, boundary: boundary)
        urlRequest.httpBody = dataBody
        return urlRequest
    }
    
    func getDocumentsFromUrlString(endpoint: Endpoint,urlString: String,onCompletion completionBlock: @escaping (Bool, Data?, Error?) -> Void) {
        let url = URL(string: endpoint.url(configurationManager) + urlString)!

        print(url)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard  error == nil else {
                print("Error fetching the image!")
                completionBlock(false,data,error)
                return
            }
            completionBlock(true,data,error)
        }
            
        dataTask.resume()
    }
    
    
    func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)".data(using: String.Encoding.utf8)!)
                body.append("\(value + lineBreak)".data(using: String.Encoding.utf8)!)
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)".data(using: String.Encoding.utf8)!)
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)".data(using: String.Encoding.utf8)!)
                body.append(photo.data)
                body.append(lineBreak.data(using: String.Encoding.utf8)!)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)".data(using: String.Encoding.utf8)!)
        
        return body
    }
    
    func generateBoundary() -> String {
           return "Boundary-\(NSUUID().uuidString)"
       }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(data: Data,fileName:String,mimeType:String,forKey key: String) {
        self.key = key
        self.mimeType = mimeType
        self.filename = fileName
        self.data = data
        
    }
    
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
