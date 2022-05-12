//
//  ForgetPasswordModel.swift
//  KFECinemas
//
//  Created by MAC on 10/05/22.
//

import Foundation

struct ForgetPasswordModel: Codable {
    let status, reason: String?
    let otp: Int?

    enum CodingKeys: String, CodingKey {
        case status
        case reason = "Reason"
        case otp
    }
}
