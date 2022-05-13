// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - BookedSeatResponse
struct BookedSeatResponse: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let data: BookedSeat?

    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseMessage = "ResponseMessage"
        case data
    }
}

// MARK: - DataClass
struct BookedSeat: Codable {
    let strSeatInfo: String?
    let intBookID: Int?
    let strTransID: String?

    enum CodingKeys: String, CodingKey {
        case strSeatInfo
        case intBookID = "intBookId"
        case strTransID = "StrTransID"
    }
}
