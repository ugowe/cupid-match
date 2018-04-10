//
//  Command.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation

protocol Command {
    func perform(arguments: [CommandArgumentKey: Any]?)
}
