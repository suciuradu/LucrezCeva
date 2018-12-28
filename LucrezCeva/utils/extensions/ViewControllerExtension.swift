//
//  ViewControllerExtension.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class var storyboardId: String {
        return "\(self)"
    }
    
    static func instantiate() -> Self {
        return viewController(viewControllerClass: self)
    }
    
    private static func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboardId, bundle: Bundle.main)
        guard let scene = storyboard.instantiateInitialViewController() as? T else { fatalError() }
        
        return scene
    }
}
