//
//  PrimaryButton.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 03/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setUpperCasedTitle(_ title: String?) {
        self.setTitle(title?.uppercased(), for: .normal)
    }
    
    private func setupView() {
        self.setUpperCasedTitle(self.currentTitle?.uppercased())
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(Colors.colorLightGray, for: .selected)
        self.layer.cornerRadius = 7
        layer.backgroundColor = Colors.colorPrimary.cgColor
    }
}

class PrimaryGradientButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setUpperCasedTitle(_ title: String?) {
        self.setTitle(title?.uppercased(), for: .normal)
    }
    
    private func setupView() {
        self.setUpperCasedTitle(self.currentTitle?.uppercased())
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(Colors.colorLightGray, for: .selected)
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.cornerRadius = 7
        applyGradient(withColours: [Colors.colorMediumTurqoise, Colors.colorTopBlue], gradientOrientation: .horizontal)
    }
}



