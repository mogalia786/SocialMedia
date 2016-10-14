//
//  FancyRoundedButton.swift
//  SocialMedia
//
//  Created by ebrahim on 10/14/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class FancyRoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowRadius = 0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0
    }
    
   
}
