//
//  TabBarVC.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 07/06/2023.
//

import UIKit

class TabBarVC: UITabBarController {

    
    //MARK: - Outlet...
    
    
    
    //MARK: - varibales...
    
    
    //MARK: - View Life Cycle...
    
    ///viewDidLoad...
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    //MARK: - Functions...
    
    ///setUpViews...
    fileprivate func setUpViews() {
        self.updateBadgeValue("2", forTabAtIndex: 0)
    }
    
    func updateBadgeValue(_ value: String?, forTabAtIndex index: Int) {
        if let tabBarItem = tabBar.items?[index] {
            tabBarItem.badgeValue = value
        }
    }
    

}
