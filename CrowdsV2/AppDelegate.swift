//
//  AppDelegate.swift
//  CrowdsV2
//
//  Created by Gaurang Bham on 4/7/16.
//  Copyright © 2016 Gaurang Bham. All rights reserved.
//

import UIKit
import GoogleMaps

// 1. Add the ESTBeaconManagerDelegate protocol
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    let googleMapsApiKey = "AIzaSyDFTyYw2d0oUd6Vk4qnvhQ1H2K7gY5zYW4"
    
   // 2. Add a property to hold the beacon manager and instantiate it
    let beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        GMSServices.provideAPIKey(googleMapsApiKey)
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        // add this below:
        self.beaconManager.requestAlwaysAuthorization()
        // add this below:
        self.beaconManager.startMonitoring(for: CLBeaconRegion(
            proximityUUID: NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")! as UUID,
            major: 11595, minor: 3035, identifier: "monitored region"))
        UIApplication.shared.registerUserNotificationSettings(
            UIUserNotificationSettings(types: .alert, categories: nil));
        return true
    }
    
    
    func beaconManager(manager: Any, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "You are near Gaurang Bham" +
            "Stay away from him cuz, " +
            "He smells like a bumm. "
        UIApplication.shared.presentLocalNotificationNow(notification)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

