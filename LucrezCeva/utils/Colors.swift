//
//  Colors.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    static var colorGreen: UIColor = {
        return UIColor.init(named: "greenColor") ?? UIColor.green
    }()
    
    static var colorRed: UIColor = {
        return UIColor.init(named: "redColor") ?? UIColor.red
    }()
    
    static var colorPrimary: UIColor = {
        return UIColor.init(named: "colorPrimary") ?? UIColor.blue
    }()
    
    static var colorLightTurqoise: UIColor = {
        return UIColor.init(named: "colorLightTurqoise") ?? UIColor.blue
    }()
    
    static var colorMediumTurqoise: UIColor = {
        return UIColor.init(named: "colorMediumTurqoise") ?? UIColor.blue
    }()
    
    static var colorTopBlue: UIColor = {
        return UIColor.init(named: "colorTopBlue") ?? UIColor.blue
    }()
    
    static var colorLightGray: UIColor = {
        return UIColor.init(named: "colorLightGray") ?? UIColor.lightGray
    }()
    
    
    
}