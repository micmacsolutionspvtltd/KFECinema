//
//  OrderSpiceKitchenModel.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import Foundation

struct OrderHistorySpiceKitchenModel: Codable , Hashable{
    let status: Int
    let reason: String
    let data: [[HistorySpiceKitchen]]?
}

// MARK: - Datum
struct HistorySpiceKitchen: Codable , Hashable {
    let foodOrderID, orderDate, totalPrice, quantity: String?
    let zone: String?
    let paymentType: String?
    let paidStatus: String?
    let itemName: String?
    let itemPrice, gst, deliveryAmount, seatNo: String?
    let showTime: String?
    let mbleNum: String?
    let email: String?
    let orderDuring: String?
    let theatreName, screenName: String?
    let diccountedAmount : String?
//    let snacksName:String?
    

    enum CodingKeys: String, CodingKey {
        case foodOrderID = "food_order_id"
        case orderDate = "order_date"
        case totalPrice = "total_price"
        case quantity, zone
        case paymentType = "payment_type"
        case paidStatus = "paid_status"
        case itemName = "item_name"
        case itemPrice = "item_price"
        case gst
        case deliveryAmount = "delivery_amount"
        case seatNo = "seat_no"
        case showTime = "show_time"
        case mbleNum = "mble_num"
        case email
        case orderDuring = "order_during"
        case theatreName = "theatre_name"
        case screenName = "screen_name"
        case diccountedAmount = "discounted_amount"
     //   case snacksName = "snacksName"
    }
}
