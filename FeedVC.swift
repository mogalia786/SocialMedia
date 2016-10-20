//
//  FeedVC.swift
//  SocialMedia
//
//  Created by ebrahim on 10/15/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
 var posts=[Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseServices.ds.REF_POSTS.observe(.value, with: {(snapshot) in
            if let snapshot=snapshot.children.allObjects as? [FIRDataSnapshot]{
                for snap in snapshot {
                    print ("snap \(snap)")
                    if let postDict=snap.value as? Dictionary<String, AnyObject>{
                        let key=snap.key
                        let post=Post.init(Postkey: key, postData: postDict)
                        
                        self.posts.append(post)
                        
                        
                    }
                }
                self.tableView.reloadData()
            }
        })
        tableView.delegate=self
        tableView.dataSource=self
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post=posts[indexPath.row]
        if let cell=tableView.dequeueReusableCell(withIdentifier: "postCell") as? postCell
        {
            cell.configureCell(post: post)
            return cell
            
        }else{
            
            return postCell()
        }
        
           }
  
    
    
    
    @IBAction func btnLogOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "gotoSignIn", sender: nil)
    }
}
