//
//  postCell.swift
//  SocialMedia
//
//  Created by ebrahim on 10/18/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likeLbl: UILabel!
    
    var post:Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(post: Post)
    {
        self.post=post
        self.caption.text=post.Caption
        self.likeLbl.text="\(post.Likes)"
        
    }
  
}
