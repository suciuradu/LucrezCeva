////
////  CreateAccountFlow.swift
////  LucrezCeva
////
////  Created by Suciu Radu on 14/12/2018.
////  Copyright © 2018 LucrezCeva. All rights reserved.
////
//
//import UIKit
//
//class CreateAccountCoordinator: Coordinator {
//    
//    var mainViewController: UIViewController? {
//        return navController
//    }
//    
//    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
//    private var navController: UINavigationController?
//    
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
////
////        createAccountFlowController = CreateAccountFlowController(with: navController!)
////        createAccountFlowController?.start()
////        addChild(coordinator: createAccountFlowController!, with: .createAccount)
////
////        completeAccountFlowController = CompleteAccountFlowController(with: navController!)
////        completeAccountFlowController?.start()
////        addChild(coordinator: completeAccountFlowController!, with: .completeAccount)
//        
//        
//    }
//    
//    
//}
