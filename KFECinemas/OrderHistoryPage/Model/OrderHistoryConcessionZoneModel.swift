//
//  OrderHistoryConcessionZoneModel.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import Foundation

struct OrderHistoryConcessionZoneModel: Codable , Hashable{
    let status: Int?
    let reason: String?
    let data: [[ConcessionHistoryData]]?
}

// MARK: - Datum
struct ConcessionHistoryData: Codable  , Hashable {
    let id, orderID, totalPrice, orderDate: String?
    let itemName: String?
    let quantity: String?
    let zone: String?
    let itemPrice: String?
    let paymentType: String?
    let gst, deliveryAmount: String
    let paidStatus: String?
    let showTime: String?
    let mbleNum: String?
    let email: String?
    let orderDuring: String?
    let theatreName, screenName, seatNo , orderConfirmId : String?
    let diccountedAmount : String?

    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case totalPrice = "total_price"
        case orderDate = "order_date"
        case itemName = "item_name"
        case quantity, zone
        case itemPrice = "item_price"
        case paymentType = "payment_type"
        case gst
        case deliveryAmount = "delivery_amount"
        case paidStatus = "paid_status"
        case showTime = "show_time"
        case mbleNum = "mble_num"
        case email
        case orderDuring = "order_during"
        case theatreName = "theatre_name"
        case screenName = "screen_name"
        case seatNo = "seat_no"
        case orderConfirmId = "order_confirm_id"
        case diccountedAmount = "discounted_amount"
    }
}
