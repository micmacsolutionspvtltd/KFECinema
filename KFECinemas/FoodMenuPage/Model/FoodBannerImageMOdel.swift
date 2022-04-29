//
//  FoodBannerImageMOdel.swift
//  KFECinemas
//
//  Created by MAC on 24/04/22.
//

import Foundation

struct FoodBannerImageModel: Codable,Hashable {
    let status: Int?
    let reason: String?
    let data: [FoodImgData]?
}

// MARK: - Datum
struct FoodImgData: Codable,Hashable {
    let foodImageName, id ,foodImageURL, activeStatus: String?
    let createdAt, updatedAt: String?
  ///  let id = UUID()

    enum CodingKeys: String, CodingKey {
        case id
        case foodImageName = "food_image_name"
        case foodImageURL = "food_image_url"
        case activeStatus = "active_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
