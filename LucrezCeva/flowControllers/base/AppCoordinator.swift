//
//  AppCoordinator.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    static var shared = AppCoordinator(in: UIWindow())
    
    private var window: UIWindow
    
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }
    
    var loginCoordinator: LoginFlowController?
    var mainCoordinator: MainCoordinator?
    
    init(in window: UIWindow) {
        self.window = window
        self.window.backgroundColor = .white
        self.window.makeKeyAndVisible()
    }
    
    public func start() {
       showMain()
    }
    
    public func showLogin() {
        loginCoordinator = LoginFlowController(with: UINavigationController())
        showCoordinator(loginCoordinator)
    }
    
    public func showMain() {
        mainCoordinator = MainCoordinator()
        showCoordinator(mainCoordinator)
    }
   
    private func showCoordinator(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { fatalError("Coordinator should be initialized") }
        rootViewController = coordinator.mainViewController
    }
}
