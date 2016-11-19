//
//  SRAppDelegate.swift
//  Telegram App
//
//  Created by Sandeep on 11/18/16.
//  Copyright © 2016 Sandeep. All rights reserved.
//

import UIKit
@UIApplicationMain
class SRAppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
        
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            self.window = UIWindow()
            // Override point for customization after application launch.
            self.window?.backgroundColor = UIColor.white
            self.window?.makeKeyAndVisible()
            
            let home = HomeViewController()
            let navController = UINavigationController(rootViewController: home);
            self.window?.rootViewController = navController;
            
            return true;
        }
        
        func applicationWillResignActive(_ application: UIApplication) {

        }
        
        func applicationDidEnterBackground(_ application: UIApplication) {

        }
        
        func applicationWillEnterForeground(_ application: UIApplication) {
        }
        
        func applicationDidBecomeActive(_ application: UIApplication) {

        }
        
        func applicationWillTerminate(_ application: UIApplication) {

        }
}

