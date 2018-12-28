//
//  SettingsViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation

class SettingsViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    private func initUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
