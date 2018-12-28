//
//  TextFieldExtension.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 03/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder(color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
