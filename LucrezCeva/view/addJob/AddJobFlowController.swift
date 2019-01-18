//
//  AddJobFlowController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class AddJobFlowController: Coordinator {
    
    var mainViewController: UIViewController?
    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
    
    init(with navigationController: UINavigationController) {
        self.mainViewController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    func start() {
        let viewController = AddJobViewController.instantiate()
        setRoot(to: viewController)
    }
}

