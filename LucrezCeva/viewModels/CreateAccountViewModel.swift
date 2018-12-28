//
//  CreateAccountViewModel.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class CreateAccountViewModel {
    weak var flowDelegate: LoginFlowDelegate?
    
    func completeAccountTapped() {
        flowDelegate?.completeAccountTapped()
    }
}
