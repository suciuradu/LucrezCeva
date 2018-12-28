//
//  BaseViewController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit
import BRYXBanner

class BaseViewController: UIViewController {
    
    public func showSuccessMessage(_ message:String) {
    let banner = Banner(title:"Success", subtitle: message, image: UIImage.init(named: "check_icon"),
    backgroundColor: Colors.colorGreen)
    banner.dismissesOnTap = true
    banner.show(duration: 2.0)
    }
    
    public func showErrorMessage(_ message:String) {
        let banner = Banner(title: "Eroare", subtitle: message, image: UIImage(named: "warning_icon"),
                            backgroundColor: Colors.colorRed)
        banner.dismissesOnTap = true
        banner.show(duration: 5.0)
    }

}

