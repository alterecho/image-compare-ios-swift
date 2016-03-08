//
//  AppDelegate.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: UIViewController?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let d1: [NSObject: AnyObject] = ["k1" : "v1", "key2" : "i want only sons"]
        let d2: NSMutableDictionary = NSMutableDictionary()
        
        
        //TODO: remove
        d2.setObject("king of the hill", forKey:"k1")
        d2.setObject("lion in the jungle", forKey:"key2")
        for k in d1 {
            print(k.dynamicType)
        }
        
        for k in d2 {
            print(k.dynamicType)
        }
        
        var element: (AnyObject, AnyObject)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible();
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

