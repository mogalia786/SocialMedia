//
//  RoundedImage.swift
//  SocialMedia
//
//  Created by ebrahim on 10/15/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.8

        
    }
    override func layoutSubviews(){
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
        clipsToBounds=true
        
    }

}
