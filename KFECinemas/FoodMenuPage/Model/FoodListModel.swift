//
//  FoodListModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 07/04/22.
//

import Foundation

struct FoodListModel: Codable ,Hashable{
    let status: Int?
    let reason: String?
    let data: [FoodDatas]?
}

// MARK: - Datum
struct FoodDatas: Codable,Hashable {
    let categoryID, categoryName: String?
    let items: [ItemInfo]?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case items
    }
}

struct FoodItems: Codable , Hashable{
    let id, sihID, itemName, itemCode: String?
    let status, categoryID, vNCatID, price: String?
    let offerPrice, foodListModelDescription, image, availability: String?
    let theatreID, createdAt, updatedAt, categoryName: String?
    let categoryCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sihID = "sih_id"
        case itemName = "item_name"
        case itemCode = "item_code"
        case status
        case categoryID = "categoryId"
        case vNCatID = "v_n_cat_id"
        case price
        case offerPrice = "offer_price"
        case foodListModelDescription = "description"
        case image, availability
        case theatreID = "theatre_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryName = "category_name"
        case categoryCode = "category_code"
    }
}
