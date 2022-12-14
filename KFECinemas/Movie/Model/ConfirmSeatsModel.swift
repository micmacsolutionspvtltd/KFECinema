//
//  ConfirmSeatsModel.swift
//  KFECinemas
//
//  Created by MAC on 02/06/22.
//

import Foundation


// MARK: - ConfirmSeatsModel
struct ConfirmSeatsModel: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let responseCode, curTotal, intException, intBookID: Int?
    let curFoodTotal: Int?
    let strTransID, strSeatInfo , strBookId , curItemsID: String?
    let curTicketsTotal, curBookingFee: Int?

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case curTotal, intException , strBookId
        case intBookID = "intBookId"
        case curFoodTotal
        case strTransID = "strTransId"
        case strSeatInfo, curTicketsTotal, curBookingFee , curItemsID
    }
}
struct SaveMovieBookingModel: Codable {
    let seatConfirmID, status: Int?
    let reason: String?

    enum CodingKeys: String, CodingKey {
        case seatConfirmID = "seat_confirm_id"
        case status, reason
    }
}
