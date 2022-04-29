// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct AllFilmsResponse: Codable {
    let responseCode: Int?
    let responseMessage: String?
    let data: [AllFilms]

    enum CodingKeys: String, CodingKey {
        case responseCode
        case responseMessage
        case data
    }
}

// MARK: - AllFilms
struct AllFilms: Codable {
    var id = UUID()
    var filmStrCode, filmStrTitle: String?
    let filmStrCensor: String?
    let filmStrContent, filmStrDescription, filmStrShortName, filmStrSignText: String?
    let filmBytSignSequence: Int?
    let filmCatStrCode, filmCatStrName, filmCatStrShortName: String?
    let filmStrChildren: String?
    let filmIntDuration: Int?
    let filmStrStatus: String?
    let filmStrATMAvailable: String?
    let filmStrShortCode: String?
    let filmIntIVRCode: Int?
    let filmStrURL1, filmStrURL2, filmStrVCode: String?
    let filmStrTitleAlt: String?
    let filmStrCensorAlt, filmStrContentAlt: String?
    let filmStrDescriptionAlt: String?
    let filmStrShortNameAlt: String?
    let filmStrSignTextAlt, filmStrURL1Description, filmStrURL2Description: String?
    let filmStrURLforGraphic: String?
    let filmStrURLforFilmName: String?
    let filmStrURLforTrailer: String?
    let filmStrMovieFormat, filmStrSoundFormat: String?
    let filmMnyGross, filmMnyLocalGross: Int?
    let filmStrUpcomingFlag, filmStrFeatureFlag, filmStrNowShowingFlag: String?
    let filmDtmOpeningDate, filmStrDescriptionLong: String?
    let filmStrAdditionalData: String?
    let filmDtmStamp, filmStrSalesChannels: String?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case filmStrCode = "Film_strCode"
        case filmStrTitle = "Film_strTitle"
        case filmStrCensor = "Film_strCensor"
        case filmStrContent = "Film_strContent"
        case filmStrDescription = "Film_strDescription"
        case filmStrShortName = "Film_strShortName"
        case filmStrSignText = "Film_strSignText"
        case filmBytSignSequence = "Film_bytSignSequence"
        case filmCatStrCode = "FilmCat_strCode"
        case filmCatStrName = "FilmCat_strName"
        case filmCatStrShortName = "FilmCat_strShortName"
        case filmStrChildren = "Film_strChildren"
        case filmIntDuration = "Film_intDuration"
        case filmStrStatus = "Film_strStatus"
        case filmStrATMAvailable = "Film_strATMAvailable"
        case filmStrShortCode = "Film_strShortCode"
        case filmIntIVRCode = "Film_intIVRCode"
        case filmStrURL1 = "Film_strURL1"
        case filmStrURL2 = "Film_strURL2"
        case filmStrVCode = "Film_strVCode"
        case filmStrTitleAlt = "Film_strTitleAlt"
        case filmStrCensorAlt = "Film_strCensorAlt"
        case filmStrContentAlt = "Film_strContentAlt"
        case filmStrDescriptionAlt = "Film_strDescriptionAlt"
        case filmStrShortNameAlt = "Film_strShortNameAlt"
        case filmStrSignTextAlt = "Film_strSignTextAlt"
        case filmStrURL1Description = "Film_strURL1Description"
        case filmStrURL2Description = "Film_strURL2Description"
        case filmStrURLforGraphic = "Film_strURLforGraphic"
        case filmStrURLforFilmName = "Film_strURLforFilmName"
        case filmStrURLforTrailer = "Film_strURLforTrailer"
        case filmStrMovieFormat = "Film_strMovieFormat"
        case filmStrSoundFormat = "Film_strSoundFormat"
        case filmMnyGross = "Film_mnyGross"
        case filmMnyLocalGross = "Film_mnyLocalGross"
        case filmStrUpcomingFlag = "Film_strUpcomingFlag"
        case filmStrFeatureFlag = "Film_strFeatureFlag"
        case filmStrNowShowingFlag = "Film_strNowShowingFlag"
        case filmDtmOpeningDate = "Film_dtmOpeningDate"
        case filmStrDescriptionLong = "Film_strDescriptionLong"
        case filmStrAdditionalData = "Film_strAdditionalData"
        case filmDtmStamp = "Film_dtmStamp"
        case filmStrSalesChannels = "Film_strSalesChannels"
        case imageURL = "Image_Url"
    }
}

