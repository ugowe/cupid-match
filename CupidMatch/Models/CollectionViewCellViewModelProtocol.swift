//
//  CollectionViewCellViewModelProtocol.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

protocol CollectionViewCellViewModelProtocol {
    var identifier: String { get }
    var commands: [CommandKey: Command] { get }
}
