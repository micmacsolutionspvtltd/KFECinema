// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ShowsResponse = try? newJSONDecoder().decode(ShowsResponse.self, from: jsonData)

import Foundation

// MARK: - ShowsResponse
struct ShowsResponse: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let data: [Shows]?

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case data
    }
}

// MARK: - Shows
struct Shows: Codable {
    let id = UUID()
    let cinemaStrID, cinemaStrName, cinemaStrLicenseName, cinemaStrLicenseNo: String?
    let shows: [Show]?

    enum CodingKeys: String, CodingKey {
        case cinemaStrID = "Cinema_strID"
        case cinemaStrName = "Cinema_strName"
        case cinemaStrLicenseName = "Cinema_strLicenseName"
        case cinemaStrLicenseNo = "Cinema_strLicenseNo"
        case shows = "Shows"
    }
}

// MARK: - Show
struct Show: Codable {
    let id = UUID()
    let showTime, cinemaStrID: String?
    let sessionLngSessionID: Int?
    let filmStrCode: String?
    let screenBytNum, layoutIntID: Int?
    let screenStrName, sessionStrStatus, sessionStrType, sessionDtmRealShow: String?
    let sessionDtmFinishShow, pGroupStrCode: String?
    let sessionIntSeatsAvail, sessionIntSeatsTotal: Int?
    let sessionStrSeatAllocation, sessionStrComments, sessionDtmFilmFirstShow, sessionStrHOSessionID: String?
    let eventStrCode, eventStrName: String?
    let sessionStrAdditionalData, sessionDtmStamp, sessionStrSalesChannel, strTicketType: String?

    enum CodingKeys: String, CodingKey {
        case showTime = "ShowTime"
        case cinemaStrID = "Cinema_strID"
        case sessionLngSessionID = "Session_lngSessionId"
        case filmStrCode = "Film_strCode"
        case screenBytNum = "Screen_bytNum"
        case layoutIntID = "Layout_intId"
        case screenStrName = "Screen_strName"
        case sessionStrStatus = "Session_strStatus"
        case sessionStrType = "Session_strType"
        case sessionDtmRealShow = "Session_dtmRealShow"
        case sessionDtmFinishShow = "Session_dtmFinishShow"
        case pGroupStrCode = "PGroup_strCode"
        case sessionIntSeatsAvail = "Session_intSeatsAvail"
        case sessionIntSeatsTotal = "Session_intSeatsTotal"
        case sessionStrSeatAllocation = "Session_strSeatAllocation"
        case sessionStrComments = "Session_strComments"
        case sessionDtmFilmFirstShow = "Session_dtmFilmFirstShow"
        case sessionStrHOSessionID = "Session_strHOSessionID"
        case eventStrCode = "Event_strCode"
        case eventStrName = "Event_strName"
        case sessionStrAdditionalData = "Session_strAdditionalData"
        case sessionDtmStamp = "Session_dtmStamp"
        case sessionStrSalesChannel = "Session_strSalesChannel"
        case strTicketType
    }
}
