//
//  CustomTableViewController.swift
//  DemoProject
//
//  Created by Rajat Sharma on 23/04/1942 Saka.
//  Copyright © 1942 InnovationM. All rights reserved.
//

import UIKit
import SDWebImage
import GoogleSignIn



class CustomTableViewController: UIViewController

{
    let sharedPreference = UserDefaults.standard
    let transiton = SlideInTransition()

    var topView: UIView?
   
 
     @IBOutlet weak var sigout: UIButton!
    
    @IBOutlet weak var userid: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var images: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        
        
    super.viewDidLoad()
        
        
    self.navigationItem.setHidesBackButton(true, animated: false)
     
 name.text=(UserDefaults.standard.value(forKey: "name") as! String)
                   email.text=(UserDefaults.standard.value(forKey: "email") as! String)
                   userid.text=(UserDefaults.standard.value(forKey: "userid") as! String)
      images.sd_setImage(with: URL(string: UserDefaults.standard.value(forKey: "image") as! String), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
  func clearAllPreference() {
       if let bundle = Bundle.main.bundleIdentifier {
          sharedPreference.removePersistentDomain(forName: bundle)
         print("Deafults released")
     }
 }
      @IBAction func signoout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
     clearAllPreference()
        print( "signed out")
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = storyboard.instantiateViewController(withIdentifier: "View") as!
        ViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    @IBAction func SlideMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
               menuViewController.didTapMenuType = { menuType in
                self.transitionToNew(menuType)
              }
               menuViewController.modalPresentationStyle = .overCurrentContext
               menuViewController.transitioningDelegate = self
               present(menuViewController, animated: true)
             
    }
func transitionToNew(_ menuType: MenuType) {
       topView?.removeFromSuperview()
        switch menuType {
            case .home:
                   let view = UIView()
                    view.frame = self.view.bounds
                     self.topView = view
        case .lost:
            let view = UIView()
            let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let sam = sigt.instantiateViewController(withIdentifier: "infoo") as! Lost
             navigationController?.pushViewController(sam, animated: false)
            view.frame = self.view.bounds
            
            self.view.addSubview(view)
            self.topView = view
        case .found:
            
            let view = UIView()
                       let sigt : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let sam = sigt.instantiateViewController(withIdentifier: "helloo") as! Found
                           
                           
                       navigationController?.pushViewController(sam, animated: false)
            view.frame = self.view.bounds
            self.view.addSubview(view)
            self.topView = view
        
       
        }
    }

    }
extension CustomTableViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}

   
 
        

   

    


   
