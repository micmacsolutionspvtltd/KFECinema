// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let SeatLayoutResponse = try? newJSONDecoder().decode(SeatLayoutResponse.self, from: jsonData)

import Foundation

// MARK: - SeatLayoutResponse
struct SeatLayoutResponse: Codable {
    let responseCode: Int?
    let responseMessage, strTransID: String?
    let screenNumber: Int?
    let screenname: String?
    let data: [SeatLayout]?


    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case strTransID
        case screenNumber = "ScreenNumber"
        case screenname = "Screenname"
        case data
    }
}

// MARK: - SeatLayout
struct SeatLayout: Codable {
    let id = UUID()
    let rowsCount: Int?
    let strAreaNum, strAreaCode, strAltAreaDesc, strAreaDesc: String?
    let amount: Int?
    let rows: [Row]?

    enum CodingKeys: String, CodingKey {
        case rowsCount = "RowsCount"
        case strAreaNum, strAreaCode, strAltAreaDesc, strAreaDesc
        case amount = "Amount"
        case rows = "Rows"
    }
}

// MARK: - Row
struct Row: Codable,Hashable {
    let intGridRowID: Int?
    let strRowPhyID: String?
    let seatsCount: Int?
    let seats: [Seat]?

    enum CodingKeys: String, CodingKey {
        case intGridRowID, strRowPhyID, seatsCount
        case seats = "Seats"
    }
}

// MARK: - Seat
struct Seat: Codable,Hashable {
    let key: String?
    let strGroupSeatType: String?
    let intGridSeatNum, dblSeatYPos, dblSeatXPos: Int?
    let strSeatStatus, strSeatNumber: String?
    let intPriority: Int?
    var strTransId:String?
    var intBookId:Int?
    var strSeatInfo:String?

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case strGroupSeatType, intGridSeatNum, dblSeatYPos, dblSeatXPos, strSeatStatus, strSeatNumber, intPriority
        case strTransId = "StrTransID"
        case intBookId = "intBookId"
        case strSeatInfo = "strSeatInfo"
    }
}
