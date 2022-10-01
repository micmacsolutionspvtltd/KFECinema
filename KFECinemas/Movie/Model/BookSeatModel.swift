//
//  BookSeatModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 11/05/22.
//

import Foundation

struct BookSeatModel {
    let movieName:String
    let theatreName:String
 //   let strTicketTypeTwo : String
    let show:Show
}


struct SeatStatusModel {
    let id = UUID()
    let imageName:String
    let status:String
}
