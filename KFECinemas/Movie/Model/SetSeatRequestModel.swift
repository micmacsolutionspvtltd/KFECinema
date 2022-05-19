//
//  SetSeatRequestModel.swift
//  KFECinemas
//
//  Created by Naveen Kumar on 12/05/22.
//

import Foundation

struct SetSeatRequestModel {
    let strTypeCode, cinemaCode, strTransID: String
    let lngSessionID: String
    let strTicketType: String
    let gridSeatRowID, gridSeatNumber: String
    let rowId:String
    
    func getJson()->[String:String]{
        return [
            "strTypeCode": self.strTypeCode,
            "CinemaCode": self.cinemaCode,
            "strTransId": self.strTransID,
            "lngSessionId": self.lngSessionID,
            "AreaCode": "0000000014",
            "strTicketType": self.strTicketType,
            "SelectedSeats": "1",
            "AreaCategoryCode":"0000000014",
            "AreaNumber":"1",
            "GridSeatRowID": self.gridSeatRowID,
            "GridSeatNumber": self.gridSeatNumber,
            "rowId": self.rowId,
          ]
    }
}
