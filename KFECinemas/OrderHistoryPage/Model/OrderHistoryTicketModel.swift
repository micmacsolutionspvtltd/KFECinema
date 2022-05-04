//
//  OrderHistoryTicketModel.swift
//  KFECinemas
//
//  Created by MAC on 29/04/22.
//

import Foundation

struct OrderHistoryTicketModel: Codable , Hashable{
    let status: Int?
    let reason: String?
    let data: [TicketHistoryData]?
}

// MARK: - Datum
struct TicketHistoryData: Codable, Hashable {
    let movieDetails: MovieDetails?
    let snacksDetails: [SnacksDetails]?

    enum CodingKeys: String, CodingKey {
        case movieDetails = "movie_details"
        case snacksDetails = "snacks_details"
    }
}

struct SnacksDetails: Codable,Hashable {
    let snacksItemName, id, orderID, orderDate: String?
    let bookingID, userID, itemName, itemID: String?
    let categoryID, quantity, price, orderTotalPrice: String?
    let priceHistoryPID, paymentType, paidStatus, isDelivered: String?
    let gst, deliveryAmount, promocodeID, isVipCardUsed: String?
    let vipCardID, calculatedDiscountAmount, calAmtFromTotalAfterDiscnt, deliverToSeatOrPickupAtCounter: String?
    let snacksDeliveryAtBegInter, orderedDuring, theatreID, showTime: String?
    let screenID, zone, seatNo, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case snacksItemName = "snacks_item_name"
        case id
        case orderID = "order_id"
        case orderDate = "order_date"
        case bookingID = "bookingId"
        case userID = "user_id"
        case itemName = "item_name"
        case itemID = "item_id"
        case categoryID = "categoryId"
        case quantity, price
        case orderTotalPrice = "order_total_price"
        case priceHistoryPID = "price_history_p_id"
        case paymentType = "payment_type"
        case paidStatus = "paid_status"
        case isDelivered = "is_delivered"
        case gst
        case deliveryAmount = "delivery_amount"
        case promocodeID = "promocode_id"
        case isVipCardUsed = "is_vip_card_used"
        case vipCardID = "vip_card_id"
        case calculatedDiscountAmount = "calculated_discount_amount"
        case calAmtFromTotalAfterDiscnt = "cal_amt_from_total_after_discnt"
        case deliverToSeatOrPickupAtCounter = "deliver_to_seat_or_pickup_at_counter"
        case snacksDeliveryAtBegInter = "snacks_delivery_at_beg_inter"
        case orderedDuring = "ordered_during"
        case theatreID = "theatre_id"
        case showTime = "show_time"
        case screenID = "screen_id"
        case zone
        case seatNo = "seat_no"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - MovieDetails
struct MovieDetails: Codable , Hashable{
    let bookingID, movieName, bookingDate, showTime: String?
    let movieAmount, snacksOrderedAmt: String?
    let theatreName , email: String?
    let screenID: String?
    let screenName: String?
    let mbleNum: String?
    let zoneInScreen: String?
    let seatNo, isSnacksOrdered, snacksPickup, isFoodOrdered: String?
    let foodPickup, totalAmount: String?
    let snacksOrderID: String?
    let isSnacksDelivered, snacksDeliveryAmt: String?

    enum CodingKeys: String, CodingKey {
        case bookingID = "booking_id"
        case movieName = "movie_name"
        case bookingDate = "booking_date"
        case showTime = "show_time"
        case movieAmount = "movie_amount"
        case snacksOrderedAmt = "snacks_ordered_amt"
        case theatreName = "theatre_name"
        case screenID = "screenId"
        case screenName = "screen_name"
        case mbleNum = "mble_num"
        case zoneInScreen = "zone_in_screen"
        case seatNo = "seat_no"
        case isSnacksOrdered = "is_snacks_ordered"
        case snacksPickup = "snacks_pickup"
        case isFoodOrdered = "is_food_ordered"
        case foodPickup = "food_pickup"
        case totalAmount = "total_amount"
        case snacksOrderID = "snacks_order_id"
        case isSnacksDelivered = "is_snacks_delivered"
        case snacksDeliveryAmt = "snacks_delivery_amt"
        case email = "email"
    }
}
