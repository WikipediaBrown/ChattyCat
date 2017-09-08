//
//  AppDelegate.swift
//  ChattyCat
//
//  Created by Perris Davis on 9/4/17.
//  Copyright © 2017 I.am.GoodBad. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Configure Firebase
        FirebaseApp.configure()
        
        // Decide which view controller
        let rootViewController = Auth.auth().currentUser?.uid == nil ? LoginViewController(): ChatDashboardViewController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }

}

