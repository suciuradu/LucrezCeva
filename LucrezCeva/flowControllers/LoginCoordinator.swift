////
////  LoginCoordinator.swift
////  LucrezCeva
////
////  Created by Suciu Radu on 14/12/2018.
////  Copyright © 2018 LucrezCeva. All rights reserved.
////
//
//import UIKit
//
//class LoginCoordinator: Coordinator {
//    
//    var mainViewController: UIViewController? {
//        return navController
//    }
//    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
//    
//    private var navController: UINavigationController?
//    
//    var loginFlowController: LoginFlowController?
//    var createAccountFlowController: CreateAccountFlowController?
//    var completeAccountFlowController: CompleteAccountFlowController?
//    
//    init() {
//        self.childCoordinators = [:]
//        
//        start()
//    }
//    
//    func start() {
//        navController = UINavigationController()
//        navController?.setNavigationBarHidden(true, animated: false)
//        
//        loginFlowController = LoginFlowController(with: navController!)
////        loginFlowController?.start()
//        addChild(coordinator: loginFlowController!, with: .login)
//        
//        createAccountFlowController = CreateAccountFlowController(with: UINavigationController())
//        addChild(coordinator: createAccountFlowController!, with: .createAccount)
//        
//        completeAccountFlowController = CompleteAccountFlowController(with: UINavigationController())
//        addChild(coordinator: completeAccountFlowController!, with: .completeAccount)
//        
//    
//    }
//}
