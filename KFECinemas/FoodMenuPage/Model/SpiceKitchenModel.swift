//
//  SpiceKitchenModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 07/04/22.
//

import Foundation



struct SpiceKitchenModelElement: Codable ,Hashable{
    let subCatID, subCatName: String?
    let itemsInfo: [ItemInfo]?

    enum CodingKeys: String, CodingKey {
        case subCatID = "sub_cat_id"
        case subCatName = "sub_cat_name"
        case itemsInfo = "items_info"
    }
}
struct ItemInfo: Codable ,Hashable{
    let itemID, id, rihID, itemName: String?
    let itemCode, status, categoryID, subCategoryID: String?
    let price, spiceKitchenModelDescription, image, availability: String?
    let createdAt, updatedAt, spiceKitchenModelCategoryID, categoryCode: String?
    let categoryName: String

    enum CodingKeys: String, CodingKey {
        case itemID = "item_id"
        case id
        case rihID = "rih_id"
        case itemName = "item_name"
        case itemCode = "item_code"
        case status
        case categoryID = "categoryId"
        case subCategoryID = "sub_categoryId"
        case price
        case spiceKitchenModelDescription = "description"
        case image, availability
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case spiceKitchenModelCategoryID = "category_id"
        case categoryCode = "category_code"
        case categoryName = "category_name"
    }
}
typealias SpiceKitchenModel = [SpiceKitchenModelElement]
