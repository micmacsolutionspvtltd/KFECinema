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
    let snacksDetails: [[String: String?]]?

    enum CodingKeys: String, CodingKey {
        case movieDetails = "movie_details"
        case snacksDetails = "snacks_details"
    }
}

// MARK: - MovieDetails
struct MovieDetails: Codable , Hashable{
    let bookingID, movieName, bookingDate, showTime: String?
    let movieAmount, snacksOrderedAmt: String?
    let theatreName: String?
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
    }
}
