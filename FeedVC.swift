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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var imageAdd: RoundedImage!
    var posts=[Post]()
    var imagePicker:UIImagePickerController!
    var imageSelected=false
    static var imageCache: NSCache<NSString, UIImage>= NSCache()
    
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
        imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=true
        imagePicker.delegate=self
        
        
    }
    
    @IBAction func addImgTapped(_ sender: AnyObject) {
        
        present(imagePicker, animated: true, completion: nil)
        
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
            if let img=FeedVC.imageCache.object(forKey: post.ImageURL as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            }else{
                
                 cell.configureCell(post: post)
            return cell

            }
            
            
            
            
        }else{
            
            return postCell()
        }
        
           }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image=info[UIImagePickerControllerEditedImage] as? UIImage{
            imageAdd.image=image
            imageSelected=true
        }else{
            print("FAIZEL A vaid image wasnt selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
  
    @IBAction func postBtnTapped(_ sender: AnyObject) {
        guard let caption=captionField.text, caption != "" else {
            print("FAIZEL: Please enter a caption")
            return
        }
        
        guard let img=imageAdd.image, imageSelected==true else{
        
            print ("FAIZEL: No image selected")
            return
        }
    
        if let imgData=UIImageJPEGRepresentation(img, 0.2){
            
            let imgUUID=NSUUID().uuidString
            let metadata=FIRStorageMetadata()
            metadata.contentType="image/jpg"
            
            databaseServices.ds.REF_POST_IMAGES.child(imgUUID).put(imgData, metadata: metadata){(metadata,error) in
                if error != nil {
                    
                    print("FAIZEL: Unable to upload image to Firebase Storage")
                    return
                    
                }else{
                    
                    print("FAIZEL: Successfully transferred toFirevase Storage")
                    
                    let downloadURL=metadata?.downloadURL()?.absoluteString
                    if let url=downloadURL {
                        self.postToFirebase(imgURL: url)
                    }
                }
            }
            
        }
    }
    
    func postToFirebase(imgURL: String){
        
            let post: Dictionary <String, Any> = [
            
            "Caption": captionField.text!,
            "Image": imgURL,
            "Likes": 0
                ]
        
            let firebasePost=databaseServices.ds.REF_POSTS.childByAutoId()
            firebasePost.setValue(post)
            
            captionField.text=""
            imageSelected=false
            imageAdd.image=UIImage(named: "add-image")
            
        }
  
    
   
    @IBAction func btnLogOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "gotoSignIn", sender: nil)
    }
}
