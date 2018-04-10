//
//  UserCollectionViewCellConfigurationCommand.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

struct UserCollectionViewCellConfigurationCommand: Command {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func perform(arguments: [CommandArgumentKey : Any]?) {
        guard let cell = arguments?[.cell] as? (UserCollectionViewCell) else {
            return
        }
        
        cell.usernameLabel.text = user.username
        cell.ageLocationLabel.text = "\(user.age) • \(user.location.cityName), \(user.location.stateCode)"
        cell.matchPercentageLabel.text = "\(String(user.matchPercentage/100))% Match"
        
        user.profileImage.downloadImage(url: user.profileImage.largeImageURL) { (profileImage) in
            DispatchQueue.main.async {
                if profileImage != nil {
                    cell.userProfileImageView.image = profileImage
                }
            }
        }
    }

}

