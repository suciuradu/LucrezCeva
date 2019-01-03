//
//  CreateAccountViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class CreateAccountViewModel {
    
    let createAccountSuccess = DynamicValue<Bool>(false)
    
    weak var flowDelegate: LoginFlowDelegate?
    
    func createAccount(fullName: String, email: String, password: String, confirmPassword: String) {
        ApiClient.shared.register(fullName, email, password, confirmPassword) { (success) in
            if success {
                self.createAccountSuccess.value = true
            } else {
                self.createAccountSuccess.value = false
            }
        }
    }
    
    func completeAccountTapped(fullName: String, email: String, password: String, image: UIImage) {
        flowDelegate?.completeAccountTapped(name: fullName, email: email, password: password, image: image)
    }
}

