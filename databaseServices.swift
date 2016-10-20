//
//  databaseServices.swift
//  SocialMedia
//
//  Created by ebrahim on 10/19/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE=FIRDatabase.database().reference()

class databaseServices

{

    static let ds = databaseServices()
    
    private var _REF_BASE=DB_BASE
    private var _REF_POSTS=DB_BASE.child("Post")
    private var _REF_USERS=DB_BASE.child("Users")
    
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
    
    func createFirebaseUsers (uid: String, userData: Dictionary<String, String>){
    
    REF_USERS.child(uid).updateChildValues(userData)
    
    }

}

