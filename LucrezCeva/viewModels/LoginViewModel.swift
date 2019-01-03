//
//  LoginViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    let loginSuccess = DynamicValue<Bool>(false)
    
    weak var flowDelegate: LoginFlowDelegate?
    
    func login(username: String, password: String){
        ApiClient.shared.login(username: username, password: password) { (response, success) in
            if success {
                self.loginSuccess.value = true
            } else {
                self.loginSuccess.value = false
            }
        }
    }
    
    func noAccountTapped() {
        flowDelegate?.noAccountTapped()
    }
}
