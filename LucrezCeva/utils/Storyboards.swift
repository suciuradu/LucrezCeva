//
//  Storyboards.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit

enum Storyboards : String {
    
    case login = "LoginScreen"
    case createAccount = "CreateAccountScreen"
    case main = "Main"
    
    private var instance : UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: Bundle.main)
    }
    
    //controller param must have it's storyboard#storyboardId attribute set to it's class name
    func instantiate<T: BaseViewController> (controller: T.Type) -> T {
        let storyboardId = (controller as BaseViewController.Type).storyboardId
        return self.instance.instantiateViewController(withIdentifier: storyboardId)
            as! T
    }
}
