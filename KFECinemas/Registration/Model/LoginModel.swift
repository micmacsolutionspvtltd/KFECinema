//
//  LoginModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 18/02/22.
//

import Foundation


// SignUpModal
struct SignUpDataModel : Codable {
    let status: Int
    let reason: String
}




// LoginModel

struct LoginDataModel: Codable {
    let status: Int?
    let reason: String?
    let data: [LoginDatas]?
}

// MARK: - Datum
struct LoginDatas: Codable {
    let id, signupType, userName, mbleNum: String?
    let password, email, vipCardStatus, fcmID: String?
    let status, otp, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case signupType = "signup_type"
        case userName = "user_name"
        case mbleNum = "mble_num"
        case password, email
        case vipCardStatus = "vip_card_status"
        case fcmID = "FCM_ID"
        case status
        case otp = "OTP"
        case createdAt = "created_at"
    }
}

