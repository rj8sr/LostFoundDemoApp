//
//  AppDelegate.swift
//  DemoProject
//
//  Created by Rajat Sharma on 23/04/1942 Saka.
//  Copyright © 1942 InnovationM. All rights reserved.
//

import UIKit

import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance()?.clientID="36680635314-udm3leee2uk5oof7ad3o7gj6minrfarm.apps.googleusercontent.com"
        return true
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return (GIDSignIn.sharedInstance()?.handle(url))!
    }
    
    
    

}

