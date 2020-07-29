//
//  ViewController.swift
//  DemoProject
//
//  Created by Rajat Sharma on 23/04/1942 Saka.
//  Copyright © 1942 InnovationM. All rights reserved.
//

import UIKit
import GoogleSignIn
class ViewController: UIViewController,GIDSignInDelegate {
   
    @IBOutlet weak var buttonSign: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController =  self 
        GIDSignIn.sharedInstance()?.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    @IBAction func SignIn(_ sender: Any) {

    GIDSignIn.sharedInstance()?.signIn()
    
    
    }
   
      func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if error != nil{
            print(error.debugDescription)
                        }
          else{
            let name = user.profile.name
            UserDefaults.standard.set(name, forKey: "name")
            let email = user.profile.email
                      UserDefaults.standard.set(email, forKey: "email")
            let userid = user.userID
                      UserDefaults.standard.set(userid, forKey: "userid")
            
            let image = user.profile.imageURL(withDimension: UInt(200))
            let urlString = image!.absoluteString
            print(urlString)
            UserDefaults.standard.set(urlString , forKey: "image")
       
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let profileVC = storyboard.instantiateViewController(withIdentifier: "CustomTable") as!
                CustomTableViewController
         
                navigationController?.pushViewController(profileVC, animated: true)
         
        
    }
                
            }
            
            
            
        }
        
      
      
  
