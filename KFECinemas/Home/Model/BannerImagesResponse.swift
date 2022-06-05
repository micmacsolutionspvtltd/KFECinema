//
//  BannerImagesResponse.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 07/04/22.
//

import Foundation


struct BannerResponseModel: Codable ,Hashable{
    let status: Int
    let reason: String
    let banners: [BannerModel]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case reason = "reason"
        case banners = "data"
        
    }
}

// MARK: - Datum
struct BannerModel: Codable,Hashable {
    let id, imageName, imageURL, activeStatus: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageName = "image_name"
        case imageURL = "image_url"
        case activeStatus = "active_status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
