//
//  databaseServices.swift
//  SocialMedia
//
//  Created by ebrahim on 10/19/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE=FIRDatabase.database().reference()
let STORAGE_BASE=FIRStorage.storage().reference()

class databaseServices

{

    static let ds = databaseServices()
    // DB References
    private var _REF_BASE=DB_BASE
    private var _REF_POSTS=DB_BASE.child("Post")
    private var _REF_USERS=DB_BASE.child("Users")
    
    // STORAGE References
    private var _REF_POST_IMAGES=STORAGE_BASE.child("post-pics")
    
    
    
    var REF_BASE:FIRDatabaseReference
        {
            return _REF_BASE
        
        }
    
    var REF_POSTS:FIRDatabaseReference
        {
            return _REF_POSTS
        }
    var REF_USERS:FIRDatabaseReference{
        
            return _REF_USERS
    }
    var REF_USER_CURENT:FIRDatabaseReference {
        
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user=REF_USERS.child(uid!)
        return user
        }
    
    
    var REF_POST_IMAGES:FIRStorageReference{
        
        return _REF_POST_IMAGES
        
    }
    
    func createFirebaseUsers (uid: String, userData: Dictionary<String, String>){
    
    REF_USERS.child(uid).updateChildValues(userData)
    
    }

}

