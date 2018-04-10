//
//  User.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let age: Int
    let matchPercentage: Int
    let location: Location
    let profileImage: ProfileImage
    
    init(username: String, age: Int, matchPercentage: Int, location: Location, profileImage: ProfileImage) {
        self.username = username
        self.age = age
        self.matchPercentage = matchPercentage
        self.location = location
        self.profileImage = profileImage
        
    }
}
