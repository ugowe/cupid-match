//
//  CollectionViewCellViewModel.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

struct CollectionViewCellViewModel: CollectionViewCellViewModelProtocol {
    let identifier: String
    let commands: [CommandKey: Command]
}

