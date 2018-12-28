//
//  Coordinator.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

enum Constants {
    enum CoordinatorKeys: String {
        case login
        case createAccount
        case completeAccount
        case main
        case home
        case addJob
        case settings
    }
}

protocol Coordinator: class {
    var mainViewController: UIViewController? { get }
    var childCoordinators: [Constants.CoordinatorKeys:Coordinator] { get set }
    
    func start()
    func addChild(coordinator: Coordinator, with key: Constants.CoordinatorKeys)
    func removeChild(coordinator: Coordinator)
}

extension Coordinator {
    
    func addChild(coordinator: Coordinator, with key: Constants.CoordinatorKeys) {
        childCoordinators[key] = coordinator
    }
    
    func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.value !== coordinator }
    }
    
}

extension Coordinator {
    func setRoot(to viewController: UIViewController) {
        if let navigationController = mainViewController as? UINavigationController {
            navigationController.navigationBar.tintColor = Colors.colorPrimary
            navigationController.navigationBar.barTintColor = UIColor.white
            navigationController.viewControllers = [viewController]
        }
    }
    
    func navigate(to viewController: UIViewController, with presentationStyle: navigationStyle, animated: Bool = true) {
        switch presentationStyle {
        case .present:
            mainViewController?.present(viewController, animated: animated, completion: nil)
        case .push:
            (mainViewController as? UINavigationController)?.pushViewController(viewController, animated: true)
        }
    }
    
}

enum navigationStyle {
    case present
    case push
}
