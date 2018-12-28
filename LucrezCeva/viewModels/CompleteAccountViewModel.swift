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
    
    func loginTapped() {
        flowDelegate?.loginTapped()
    }
}
