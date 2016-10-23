//
//  Posts.swift
//  SocialMedia
//
//  Created by ebrahim on 10/20/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import Foundation
import Firebase
class Post{

    private var  _caption: String!
    private var  _imageURL: String!
    private var  _likes: Int!
    private var  _postKey: String!
    private var  _postRef: FIRDatabaseReference!
    
    var Caption: String {
    return _caption
    
    }
    
    
    var ImageURL:String{
    return _imageURL
    }
    
    var Likes: Int{
    return _likes
    }
    
    var PostKey: String{
    return _postKey
    }
    
    init(Caption: String, ImageURL: String, Likes: Int){
        self._likes=Likes
        self._caption=Caption
        self._imageURL=ImageURL
    }
    
    init(Postkey: String, postData: Dictionary <String, AnyObject>)
    {
        self._postKey=Postkey
        if let Caption = postData["Caption"] as? String{
            
            self._caption = Caption
        }
        
        if let ImageURL = postData["Image"] as? String{
            self._imageURL=ImageURL
            
        }
        
        if let Likes = postData["Likes"] as? Int{
            self._likes=Likes
            
        }
        _postRef=databaseServices.ds.REF_POSTS.child(Postkey)
        
    }
    func adjustLikes(addLike: Bool){
        if addLike    {
            _likes=_likes+1
        }else{
            
            _likes=_likes-1
            
        }
        _postRef.child("Likes").setValue(_likes)
        
    }
}
