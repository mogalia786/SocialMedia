//
//  postCell.swift
//  SocialMedia
//
//  Created by ebrahim on 10/18/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import Firebase

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

    func configureCell(post: Post, img: UIImage?=nil)
    {
        self.post=post
        self.caption.text=post.Caption
        self.likeLbl.text="\(post.Likes)"
        
        if img != nil{
            
            self.postImg.image=img
        }else{
            let ref=FIRStorage.storage().reference(forURL: post.ImageURL)
            ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                
                if error != nil {
                    
                    print("FAIZEL: Image failed to download")
                }else{
                    
                    print("FAIZEL: Image downloaded from FIRStorage")
                    if let imgData = data{
                        if let img=UIImage(data: imgData){
                            self.postImg.image=img
                            FeedVC.imageCache.setObject(img, forKey: post.ImageURL as NSString)
                            
                            
                        }
                        
                    }
                }
                
                
            })
            
            
        }
        
    }
  
}
