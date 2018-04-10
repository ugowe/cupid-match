//
//  UserCollectionViewCellViewModelFactory.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

struct UserCollectionViewCellViewModelFactory {
    
    private let user: User
    private weak var viewController: UIViewController?
    
    init(user: User, viewController: UIViewController?) {
        self.user = user
        self.viewController = viewController
    }
    
    func create() -> CollectionViewCellViewModelProtocol {
        let configurationCommand = UserCollectionViewCellConfigurationCommand(user: user)
        let commands: [CommandKey: Command] = [
            .configuration: configurationCommand
        ]
        
        return CollectionViewCellViewModel(identifier: "UserCollectionViewCell", commands: commands)
    }
}
