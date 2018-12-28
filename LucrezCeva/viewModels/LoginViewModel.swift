//
//  LoginViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    weak var flowDelegate: LoginFlowDelegate?
    
    func noAccountTapped() {
        flowDelegate?.noAccountTapped()
    }
}
