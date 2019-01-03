//
//  CompleteAccountViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class CompleteAccountViewModel {
    weak var flowDelegate: LoginFlowDelegate?
    
    let updateAccountSuccess = DynamicValue<Bool>(false)
    
    func updateAccountDetails(birthDay: String, location: String, gender: String, phone: String, tags: [String]) {
        ApiClient.shared.updateAccountDetails(birthDay, location, gender, phone, tags) { (success) in
            if success {
                self.updateAccountSuccess.value = true
            } else {
                self.updateAccountSuccess.value = false
            }
        }
    }
    
    func loginTapped() {
        flowDelegate?.loginTapped()
    }
}
