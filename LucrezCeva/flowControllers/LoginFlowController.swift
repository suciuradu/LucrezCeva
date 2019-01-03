//
//  LoginFlowController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class LoginFlowController: Coordinator {
    
    var mainViewController: UIViewController?
    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
    
    init(with navigationController: UINavigationController) {
        self.mainViewController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    func start() {
        let viewController = LoginViewController.instantiate()
        let viewModel = LoginViewModel()
        viewModel.flowDelegate = self
        viewController.viewModel = viewModel
        setRoot(to: viewController)
    }
}

extension LoginFlowController: LoginFlowDelegate {
    func completeAccountTapped(name: String, email: String, password: String, image: UIImage) {
        let viewController = CompleteAccountViewController.instantiate()
        let viewModel = CompleteAccountViewModel()
        viewModel.flowDelegate = self
        viewController.viewModel = viewModel
        viewController.fullName = name
        viewController.profilePictureImage = image
        navigate(to: viewController, with: .push)
    }
    
    func loginTapped() {
        AppCoordinator.shared.showMain()
    }
    
    func noAccountTapped() {
        let viewController = CreateAccountViewController.instantiate()
        let viewModel = CreateAccountViewModel()
        viewModel.flowDelegate = self
        viewController.viewModel = viewModel
        navigate(to: viewController, with: .push)
    }
    
    
}
