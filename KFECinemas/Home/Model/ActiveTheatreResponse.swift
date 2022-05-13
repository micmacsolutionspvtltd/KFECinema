
import Foundation

// MARK: - ActiveTheatreResponse
struct ActiveTheatreResponse: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let data: [Theatre]?

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case data
    }
}

// MARK: - Theatre
struct Theatre: Codable {
    let id = UUID()
    let cinemaStrID, cinemaStrName, cinemaStrLicenseName, cinemaStrLicenseNo: String?
    let cinemaStrIsOnline, cinemaStrBranchCode, cinemaStrUseHOCode: String?

    enum CodingKeys: String, CodingKey {
        case cinemaStrID = "Cinema_strID"
        case cinemaStrName = "Cinema_strName"
        case cinemaStrLicenseName = "Cinema_strLicenseName"
        case cinemaStrLicenseNo = "Cinema_strLicenseNo"
        case cinemaStrIsOnline = "Cinema_strIsOnline"
        case cinemaStrBranchCode = "Cinema_strBranchCode"
        case cinemaStrUseHOCode = "Cinema_strUseHOCode"
    }
}
