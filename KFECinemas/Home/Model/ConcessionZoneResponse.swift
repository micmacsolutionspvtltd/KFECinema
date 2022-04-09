//
//  ConcessionZoneResponse.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/04/22.
//

import Foundation


struct ConcessionZoneResponse: Codable {
    let status: Int
    let reason: String
    let data: [ConcessionZoneItem]
}

// MARK: - Datum
struct ConcessionZoneItem: Codable {
    let id = UUID()
    let itemInfo: ConcessionZoneItemInfo?
    let categoryName, categoryID: String

    enum CodingKeys: String, CodingKey {
        case itemInfo = "item_info"
        case categoryName = "category_name"
        case categoryID = "category_id"
    }
}

struct ConcessionZoneItemInfo: Codable {
    let id, sihID, itemName, itemCode: String?
    let status, categoryID, vNCatID, price: String?
    let gst: String?
    let offerPrice, welcomeDescription, image, availability: String?
    let theatreID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sihID = "sih_id"
        case itemName = "item_name"
        case itemCode = "item_code"
        case status = "status"
        case categoryID = "categoryId"
        case vNCatID = "v_n_cat_id"
        case price, gst
        case offerPrice = "offer_price"
        case welcomeDescription
        case image, availability
        case theatreID = "theatre_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
