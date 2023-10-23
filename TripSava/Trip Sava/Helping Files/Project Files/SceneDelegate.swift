//
//  SceneDelegate.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 05/06/2023.
//

import UIKit
import Reachability


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?  
    var reachability: Reachability?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        setUpreachability()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        stopReachability()
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    
    ///setUpreachability..
    func setUpreachability() {
            reachability = try? Reachability()
            do {
                try reachability?.startNotifier()
                NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(_:)), name: .reachabilityChanged, object: reachability)
            } catch { print("Error starting reachability notifier: \(error)")  }
        }
    
    ///stopReachability...
    func stopReachability(){
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        
    }
    
    @objc func reachabilityChanged(_ notification: Notification) {
        if let reachability = notification.object as? Reachability {
            if reachability.isReachable {
                hideNoInternetViewController()
            } else {
                showNoInternetViewController()
            }
        }
        
    }
    
    private func showNoInternetViewController() {
        guard let rootViewController = window?.rootViewController else {
            return
        }
        let storyboard = UIStoryboard(name: "Alert", bundle: nil)
        guard let noInternetViewController = storyboard.instantiateViewController(identifier: "NoInternetViewController") as? NoInternetViewController else {
            print("ViewController not found")
            return
        }
        
        // Create your custom NoInternetViewController
        rootViewController.addChild(noInternetViewController)
        rootViewController.view.addSubview(noInternetViewController.view)
        
        // Set the frame for the NoInternetViewController's view
        noInternetViewController.view.frame = window!.frame
        
        noInternetViewController.didMove(toParent: rootViewController)
        
      
    }
    
    
    
    private func hideNoInternetViewController() {
        guard let rootViewController = window?.rootViewController,
              let noInternetViewController = rootViewController.children.first(where: { $0 is NoInternetViewController }) else {
            return
        }
        
        noInternetViewController.willMove(toParent: nil)
        noInternetViewController.view.removeFromSuperview()
        noInternetViewController.removeFromParent()
    }
    
}
