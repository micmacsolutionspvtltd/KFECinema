//
//  ForgetPasswordViewModel.swift
//  KFECinemas
//
//  Created by MAC on 10/05/22.
//

import Foundation


class ForgetPasswordViewModel : ObservableObject{
    
    func forgetPasswordOtpSendApi(mobileNUm : String , completionHandler :  @escaping((ForgetPasswordModel) -> Void) ){
        let params : [String : String]?
      params = [
        "mble_num": mobileNUm,
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.forgotPasswordGenerateOtp,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ForgetPasswordModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
    }
    func forgetPasswordOtpCheckApi(mobileNUm : String , newPassword : String, otp : String, completionHandler :  @escaping((ForgetPasswordModel) -> Void) ){
        let params : [String : String]?
      params = [
        "mble_num": mobileNUm,
        "new_password" : newPassword,
        "OTP" : otp
        ]
        let urlRequest = (try?  RequestGenerator.sharedInstance.generateURLRequestTypeTwo(endpoint:Endpoint.forgotPasswordGenerateOtp,requestBody: params))!
        NetWorkManger.sharedInstance.postData(request: urlRequest, resultType: ForgetPasswordModel.self) { (restValue, result, error) in
            DispatchQueue.main.async {
            if restValue == true{
            //    self.getPromoCodeData = result
                completionHandler(result!)
            }else{
             
            }
            }
        }
    }
}
