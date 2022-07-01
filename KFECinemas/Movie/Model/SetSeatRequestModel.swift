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
    let areaCode ,areaNum : String
    
    func getJson()->[String:String]{
        return [
            "strTypeCode": self.strTypeCode,
            "CinemaCode": self.cinemaCode,
            "strTransId": self.strTransID,
            "lngSessionId": self.lngSessionID,
            "AreaCode": self.areaCode,
            "strTicketType": self.strTicketType,
            "SelectedSeats": "1",
            "AreaCategoryCode":self.areaCode,
            "AreaNumber":self.areaNum,
            "GridSeatRowID": self.gridSeatRowID,
            "GridSeatNumber": self.gridSeatNumber,
            "rowId": self.rowId,
          ]
    }
}
