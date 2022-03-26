//
//  Configuration.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import UIKit
enum Configuration: String {
    case dev
    case prod

    // TODO: Updatate domain for staging and prod
    var baseURL: String {
        var domain: String
        switch self {
        case .dev: domain = "http://13.232.119.26:8080/peopletrack"
        case .prod: domain = "http://13.232.119.26:8080/peopletrack"
        }
        return "\(domain)"
    }
    
}
