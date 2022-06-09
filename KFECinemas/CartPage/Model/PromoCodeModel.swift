//
//  PromoCodeModel.swift
//  KFECinemas
//
//  Created by MAC on 05/05/22.
//

import Foundation



// MARK: - PromoCheckModel
struct PromoCheckModel: Codable , Hashable{
    let status, reason: String?
    let data: [PromoData]?
}

// MARK: - Datum
struct PromoData: Codable , Hashable{
    let id, promocode, discount, maximumAmount: String?
    let minOrderedAmt, expiryFrom, expiryTo, noExpiry: String?
    let paymentType, offerType, foodOrderingPeople, snacksOrderingPeople: String?
    let serviceArea, images, datumDescription, status: String?
    let createdAt, updatedAt, expiryFromTime, expiryToTime: String?
    let promoType, userid, notinuseDate, products: String?
    let days, noOfTimes: String?

    enum CodingKeys: String, CodingKey {
        case id, promocode, discount
        case maximumAmount = "maximum_amount"
        case minOrderedAmt = "min_ordered_amt"
        case expiryFrom = "expiry_from"
        case expiryTo = "expiry_to"
        case noExpiry = "no_expiry"
        case paymentType = "payment_type"
        case offerType = "offer_type"
        case foodOrderingPeople = "food_ordering_people"
        case snacksOrderingPeople = "snacks_ordering_people"
        case serviceArea = "service_area"
        case images
        case datumDescription = "description"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case expiryFromTime = "expiry_from_time"
        case expiryToTime = "expiry_to_time"
        case promoType = "promo_type"
        case userid
        case notinuseDate = "notinuse_date"
        case products, days
        case noOfTimes = "no_of_times"
    }
}


// MARK: - PromoCalculateModel
struct PromoAmtCalculateModel: Codable {
    let status, reason: String?
    let data: PromoAmtCalculateData?
}

// MARK: - DataClass
struct PromoAmtCalculateData: Codable {
    let appliedPromo, orderTotalAmount, discoutPer, discountMaxAmt: String?
    let calculatedDiscountAmount: String?
    let discountedAmountFromTotal: String?

    enum CodingKeys: String, CodingKey {
        case appliedPromo = "applied_promo"
        case orderTotalAmount = "order_total_amount"
        case discoutPer = "discout_per"
        case discountMaxAmt = "discount_max_amt"
        case calculatedDiscountAmount = "calculated_discount_amount"
        case discountedAmountFromTotal = "discounted_amount_from_total"
    }
}
