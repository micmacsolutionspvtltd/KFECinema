//
//  ConfigurationManager.swift
//  FitKet
//
//  Created by Hariharan G on 5/19/20.
//  Copyright © 2020 Fitket. All rights reserved.
//

import UIKit

class ConfigurationManager: NSObject {
    let configuration: Configuration

    override init() {
        let environmentValue = Util.shared.getValueFromInfoDict(key: Constants.environmentKey )!
        configuration = Configuration(rawValue: environmentValue)!
    }
}

