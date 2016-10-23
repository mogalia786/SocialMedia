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
    @IBOutlet  weak var likeImg: UIImageView!
    
    
    var post:Post!
    var likeRef:FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tap=UITapGestureRecognizer (target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired=1
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled=true
        
    }

    func configureCell(post: Post, img: UIImage?=nil)
    {
        self.post=post

        likeRef=databaseServices.ds.REF_USER_CURENT.child("Likes").child(post.PostKey)
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
        
        
        likeRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image=UIImage(named: "empty-heart")
            }else{
                self.likeImg.image=UIImage(named: "filled-heart")
                
            }
        })
        
    }
    func likeTapped(sender: UITapGestureRecognizer){
        
        likeRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image=UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likeRef.setValue(true)
            }else{
                self.likeImg.image=UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likeRef.removeValue()
            }
        })
  
        
    }
  
}
