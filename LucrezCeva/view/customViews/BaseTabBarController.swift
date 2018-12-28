//
//  BaseTabBar.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 27/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = Colors.colorPrimary
        self.tabBar.unselectedItemTintColor = UIColor.lightGray
    }
}
