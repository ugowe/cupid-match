//
//  Location.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation

struct Location {
    let countryName: String
    let countryCode: String
    let stateName: String
    let stateCode: String
    let cityName: String
    
    init(countryName: String, countryCode: String, stateName: String, stateCode: String, cityName: String) {
        self.countryName = countryName
        self.countryCode = countryCode
        self.stateName = stateName
        self.stateCode = stateCode
        self.cityName = cityName
    }
}
