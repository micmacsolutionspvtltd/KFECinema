//
//  SpiceKitchenResponse.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 09/04/22.
//

import Foundation


struct SpiceKitchenResponse: Codable {
    let status: Int
    let reason: String
    let data: [SpiceKitchen]
}

// MARK: - Datum
struct SpiceKitchen: Codable {
    let id = UUID()
    let itemInfo: SpiceKitchenItemInfo?
    let categoryName, subCategoryName: String

    enum CodingKeys: String, CodingKey {
        case itemInfo = "item_info"
        case categoryName = "category_name"
        case subCategoryName = "sub_category_name"
    }
}

struct SpiceKitchenItemInfo: Codable {
    let id, rihID: String?
    let restaurantID: String?
    let itemName, itemCode, status, categoryID: String?
    let subCategoryID, price: String?
    let gst, offerPrice: String?
    let welcomeDescription, image, availability, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case rihID = "rih_id"
        case restaurantID = "restaurantId"
        case itemName = "item_name"
        case itemCode = "item_code"
        case status = "status"
        case categoryID = "categoryId"
        case subCategoryID = "sub_categoryId"
        case price, gst
        case offerPrice = "offer_price"
        case welcomeDescription = "description"
        case image, availability
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
