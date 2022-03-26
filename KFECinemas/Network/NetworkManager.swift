//
//  NetworkManager.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import Foundation
import SystemConfiguration


class EmptyResponse: Codable{
    
}
class NetworkManager: NSObject {
    static var sharedInstance = NetworkManager()
    
    func processRequest<T: Codable>(request: URLRequest, responseType: T.Type, onCompletion completionBlock: @escaping (Bool, T?, Error?) -> Void) {
        guard isConnectedToNetwork else {
            completionBlock(false, nil, NetworkError.noInternetAccess)
            return
        }
        print("==========Request==========\n\(request.debugDescription)")
        
        
        URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            guard error == nil, let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                self?.executeCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                return
            }

            guard httpResponse.statusCode == 200 else {
                self?.executeCompletionBlock(completionBlock, withResults: false, response: nil, error: self?.getErrorFromStatusCode(statusCode: httpResponse.statusCode, message: error?.localizedDescription))
                return
            }
            var resultObj: T?
            var success: Bool = false
            var message: String?
            var errorToSend: Error? = nil
            do {
                var json:Any?
                
                if let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] {
                   json = jsonData
                }else if let jsonDataValue = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [[String: Any]] {
                    json = jsonDataValue
                }else{
                    self?.executeCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                    return
                }
            
                let statusCode = httpResponse.statusCode
//                message = json["strMessage"] as? String
                
                if let jsonValue = json as? [String:Any],let message = jsonValue["message"] as? String  {
                    self?.executeCompletionBlock(completionBlock, withResults: false, response: nil, error: self?.getErrorFromStatusCode(statusCode: 403, message: message))
                    return
                }else{
                    if statusCode == 200 {
                        let expectedresponse = json
                        print("==========Response==========\n\(expectedresponse)")
                        print("==============================\n")
                        success = true
                        if T.self != EmptyResponse.self {
                            let responseToDecode = try JSONSerialization.data(withJSONObject: expectedresponse, options: .prettyPrinted)
                            let respnseObj = try JSONDecoder().decode(T.self, from: responseToDecode)
                            resultObj = respnseObj
                        }
                        else {
                            resultObj = nil
                        }
                    } else {
                        errorToSend = self?.getErrorFromStatusCode(statusCode: statusCode, message: "message")
                        resultObj = nil
                    }
                }
                
            } catch let exception as Error {
                success = false
                errorToSend = error
                print (exception)
                resultObj = nil
            }
            self?.executeCompletionBlock(completionBlock, withResults: success, response: resultObj, error: errorToSend)
        }.resume()
    }
    
    func processNewRequest<T: Codable>(request: URLRequest, responseType: T.Type, onCompletion completionBlock: @escaping (Bool, NewGenericResponse<T>?, Error?) -> Void) {
        guard isConnectedToNetwork else {
            completionBlock(false, nil, NetworkError.noInternetAccess)
            return
        }
        print("==========Request==========\n\(request.debugDescription)")
        
        
        URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            guard error == nil, let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                self?.executeNewCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                return
            }

            guard httpResponse.statusCode == 200 else {
                self?.executeNewCompletionBlock(completionBlock, withResults: false, response: nil, error: self?.getErrorFromStatusCode(statusCode: httpResponse.statusCode, message: error?.localizedDescription))
                return
            }

            var resultObj: NewGenericResponse<T>?
            var success: Bool = false
            var message: String?
            var errorToSend: Error? = nil

            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] else {
                    self?.executeNewCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                    return
                }
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    
                    guard  let statusCode = json["statusCode"] as? Int,statusCode == 0 || statusCode == 200 else {
                        return
                    }
                    let errorDescription = json["errorDescription"] as? String ?? nil
                    let errorMessage = json["errorMessage"] as? String ?? nil
                    let responseMessage = json["responseMessage"] as? String ?? nil
                    let responseFlag = json["responseFlag"] as? Int ?? nil
                    let response = json["response"] ?? nil
                
                    print("==========Response==========\n\(response)")
                    print(responseMessage)
                    print(responseFlag)
                    print("==============================\n")
                
                    success = true
                    if T.self != EmptyResponse.self {
                        if response is NSNull {
                            resultObj =
                                NewGenericResponse<T>(errorDescription: errorDescription, errorMessage: errorMessage, responseMessage: responseMessage, statusCode: statusCode, response: nil, responseFlag: responseFlag)
                        }else {
                            
                            let responseToDecode = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                            let respnseObj = try JSONDecoder().decode(T.self, from: responseToDecode)
                            resultObj =  NewGenericResponse<T>(errorDescription: errorDescription, errorMessage: errorMessage, responseMessage: responseMessage, statusCode: statusCode, response: respnseObj,responseFlag: responseFlag)
                        }
                        
                    }
                    else {
                        resultObj =
                            NewGenericResponse<T>(errorDescription: errorDescription, errorMessage: errorMessage, responseMessage: responseMessage, statusCode: statusCode, response: nil, responseFlag: responseFlag)
                    }
                } else {
                    errorToSend = self?.getErrorFromStatusCode(statusCode: statusCode, message: message)
                    resultObj =
                        NewGenericResponse<T>(errorDescription: nil, errorMessage: nil, responseMessage: nil, statusCode: nil, response: nil, responseFlag: nil)
                }
            } catch let exception as Error {
                success = false
                errorToSend = error
                print (exception)
                resultObj =
                    NewGenericResponse<T>(errorDescription: nil, errorMessage: nil, responseMessage: nil, statusCode: nil, response: nil, responseFlag: nil)
            }
            self?.executeNewCompletionBlock(completionBlock, withResults: success, response: resultObj, error: errorToSend)
        }.resume()
    }
    
    func processEmptyRequest<T: Codable>(request: URLRequest, responseType: T.Type, onCompletion completionBlock: @escaping (Bool,[String:Any]?, Error?) -> Void) {
        guard isConnectedToNetwork else {
            completionBlock(false, nil, NetworkError.noInternetAccess)
            return
        }
        print("==========Request==========\n\(request.debugDescription)")
        
        
        URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            guard error == nil, let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                self?.executeEmptyCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                return
            }

            guard httpResponse.statusCode == 200 else {
                self?.executeEmptyCompletionBlock(completionBlock, withResults: false, response: nil, error: self?.getErrorFromStatusCode(statusCode: httpResponse.statusCode, message: error?.localizedDescription))
                return
            }

            var resultObj: [String:Any]?
            var success: Bool = false
            var message: String?
            var errorToSend: Error? = nil

            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] else {
                    self?.executeEmptyCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                    return
                }
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    
                    guard  let statusCode = json["statusCode"] as? Int,statusCode == 0 else {
                        return
                    }
                    
                    if let response = json["response"] as? [String:Any] {
                        success = true
                        resultObj = response
                        print("==========Response==========\n\(response)")
                        print("==============================\n")
                    }else {
                        resultObj = [:]
                    }
                } else {
                    errorToSend = self?.getErrorFromStatusCode(statusCode: statusCode, message: message)
                    resultObj = [:]
                }
            } catch let exception {
                success = false
                errorToSend = error
                print(exception)
                resultObj = [:]
            }
            self?.executeEmptyCompletionBlock(completionBlock, withResults: success, response: resultObj, error: errorToSend)
        }.resume()
    }
    
    func processBookFuelRequest<T: Codable>(request: URLRequest, responseType: T.Type, onCompletion completionBlock: @escaping (Bool, BookFuelResponse<T>?, Error?) -> Void) {
        guard isConnectedToNetwork else {
            completionBlock(false, nil, NetworkError.noInternetAccess)
            return
        }
        print("==========Request==========\n\(request.debugDescription)")
        
        
        URLSession.shared.dataTask(with: request) { [weak self](data, response, error) in
            guard error == nil, let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                self?.executeBookCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                return
            }

            guard httpResponse.statusCode == 200 else {
                self?.executeBookCompletionBlock(completionBlock, withResults: false, response: nil, error: self?.getErrorFromStatusCode(statusCode: httpResponse.statusCode, message: error?.localizedDescription))
                return
            }

            var resultObj: BookFuelResponse<T>?
            var success: Bool = false
            var message: String?
            var errorToSend: Error? = nil

            do {
                guard let json = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] else {
                    self?.executeBookCompletionBlock(completionBlock, withResults: false, response: nil, error: error)
                    return
                }
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    let expectedresponse = json["response"] ?? nil
                    let message = json["responseMessage"] ?? nil
                    let code = json["statusCode"] ?? nil
                    print("==========Response==========\n\(expectedresponse)")
                    print("==============================\n")
                    success = true
                    if T.self != EmptyResponse.self {
                        let responseToDecode = try JSONSerialization.data(withJSONObject: expectedresponse, options: .prettyPrinted)
                        let respnseObj = try JSONDecoder().decode(T.self, from: responseToDecode)
                        resultObj = BookFuelResponse<T>(response: respnseObj,responseMessage: message as? String, statusCode: code as? Int)
                    }
                    else {
                        resultObj = BookFuelResponse<T>(response: nil,responseMessage: nil,statusCode: nil)
                    }
                } else {
                    errorToSend = self?.getErrorFromStatusCode(statusCode: statusCode, message: message)
                    resultObj = BookFuelResponse<T>(response: nil,responseMessage: nil,statusCode: nil)
                }
            } catch let exception as Error {
                success = false
                errorToSend = error
                print (exception)
                resultObj = BookFuelResponse<T>(response: nil,responseMessage: nil,statusCode: nil)
            }
            self?.executeBookCompletionBlock(completionBlock, withResults: success, response: resultObj, error: errorToSend)
        }.resume()
    }
    
   
    
    private func getErrorFromStatusCode(statusCode: Int, message: String?) -> NetworkError? {
        switch statusCode {
        case 200: return nil
        case 403,405: return NetworkError.sessionExpired
        case 400, 1006: return NetworkError.unknown(reason: message ?? ErrorConstants.badRequest)
        case 401, 2001, 2000: return NetworkError.unAuthorised
        case 404: return NetworkError.unknown(reason: ErrorConstants.resourceNotFound)
        case let x where x > 499: return NetworkError.serverError(reason: message ?? ErrorConstants.serverError)
        default: return NetworkError.unknown(reason: message ?? ErrorConstants.genericErrorMessage)
        }
    }

    private func executeBookCompletionBlock<T: Codable>(_ block: @escaping (Bool, BookFuelResponse<T>?, Error?) -> Void, withResults success: Bool, response: BookFuelResponse<T>?, error: Error?) {
         let queue: DispatchQueue = .global()

         queue.async {
            block(success, response, error)
        }
    }

    private func executeNewCompletionBlock<T: Codable>(_ block: @escaping (Bool, NewGenericResponse<T>?, Error?) -> Void, withResults success: Bool, response: NewGenericResponse<T>?, error: Error?) {
         let queue: DispatchQueue = .global()

         queue.async {
            block(success, response, error)
        }
    }
    
    private func executeEmptyCompletionBlock(_ block: @escaping (Bool, [String:Any]?, Error?) -> Void, withResults success: Bool, response: [String:Any]?, error: Error?) {
         let queue: DispatchQueue = .global()

         queue.async {
            block(success, response, error)
        }
    }

    private func executeCompletionBlock<T: Codable>(_ block: @escaping (Bool, T?, Error?) -> Void, withResults success: Bool, response: T?, error: Error?) {
         let queue: DispatchQueue = .global()

         queue.async {
            block(success, response, error)
        }
    }
    
    
    

    var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func getWiFiAddress() -> String {
        var address : String?
        
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return "" }
        guard let firstAddr = ifaddr else { return "" }
        
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    var addr = interface.ifa_addr.pointee
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        if let addressValue = address {
            return addressValue
        }else {
            return "192.168.0.116"
        }
    }
}
