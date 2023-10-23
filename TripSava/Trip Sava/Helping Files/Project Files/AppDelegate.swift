//
//  AppDelegate.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/06/2023.
//

import UIKit 
import SmartlookAnalytics

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Smartlook.instance.preferences.projectKey = "89a298e9294f45ed2b2a91b0867c7c9c333dd299"
        Smartlook.instance.start()
        
        sleep(2)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    ///applicationWillTerminate...
    func applicationWillTerminate(_ application: UIApplication) { }
    
    
    
}
