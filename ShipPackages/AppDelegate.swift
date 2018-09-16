
//  AppDelegate.swift
//  ShipPackages
//
//  Created by Waleed Mastour on 9/8/18.
//  Copyright © 2018 Waleed Mastour. All rights reserved.
//
enum userType {
    case driver
    case custmer
    case notSign
}

import UIKit
import Firebase
import SideMenuSwift

let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var containerVC = ContainerVC()
    var cureentuserType:userType = userType.custmer
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        containerVC = ContainerVC()
        FirebaseApp.configure()
//        if Auth.auth().currentUser != nil{
//            window?.rootViewController = containerVC
//            window?.makeKeyAndVisible()
//        }
//        // Override point for customization after application launch.
        
        SideMenuController.preferences.basic.position = .under
        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
