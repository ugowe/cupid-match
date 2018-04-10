//
//  UserCollectionViewCell.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ageLocationLabel: UILabel!
    @IBOutlet weak var matchPercentageLabel: UILabel!
    @IBOutlet weak var userProfileImageView: UIImageView! {
        didSet {
            userProfileImageView.contentMode = .scaleAspectFill
            userProfileImageView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userProfileImageView.image = nil
    }
    
}
