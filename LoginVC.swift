//
//  ViewController.swift
//  SocialMedia
//
//  Created by ebrahim on 10/13/16.
//  Copyright © 2016 iSTROBE. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper
class LoginVC: UIViewController {

    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        if let _=KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "gotoFeed", sender: nil)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////FACEBOOK CODE AUTH
    
    @IBAction func btn(_ sender: AnyObject) {
        
        let facebookLogin=FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) {
            (result, error) in
            if error != nil {
                
                print("FAIZEL :unable to authenticate user - \(error)")
                
            }
            else if result?.isCancelled==true
            {
                print("FAIZEL :user cancelled authentication")
                
            }
            else
            {
                
                print("FAIZEL :Successfully authenticated with FaceBook")
                let credential=FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
        }

    }
    
       ////FIREBASE AUTH L
    func firebaseAuth(_ credential: FIRAuthCredential)
    {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil
            {
                print("FAIZEL :unable to authenticate user FIREBASE - \(error)")
                
            }
            else
            {
                print("FAIZEL :Successfully Authenticated with FIREBASE")
                
                self.completeSignIn(id: (user?.uid)!)

            }
            
            
            
        })
        
    }
    
    @IBAction func emailTapped(_ sender: AnyObject) {
        if let email=Email.text, let pwd=Password.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error==nil{
                    print("FAIZEL: Email User asuthenticated with FIREBASE")
                    self.completeSignIn(id: (user?.uid)!)

                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil{
                            print("FAIZEL: unable to authenticate with FIREBASE using email \(error)")
                        }else{
                            self.completeSignIn(id: (user?.uid)!)
                            print("FAIZEL: Successfully authenticated with FIREBASE")
                            self.completeSignIn(id: (user?.uid)!)

                        }
                    })
                }
            })
            
            
            
        }
        
        
        
    }
    func completeSignIn(id: String)
    {
    KeychainWrapper.standard.set(id, forKey: KEY_UID)
    performSegue(withIdentifier: "gotoFeed", sender: nil)
        
    }
}
