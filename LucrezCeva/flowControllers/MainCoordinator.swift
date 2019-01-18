//
//  MainCoordinator.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 14/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var mainViewController: UIViewController? {
        return tabBarController
    }
    
    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
    var homeCoordinator: HomeFlowController?
    var addJobCoordinator: AddJobFlowController?
    var settingsCoordinator: SettingsFlowController?
    
    private var tabBarController: BaseTabBarController?
    
    init() {
        self.childCoordinators = [:]
        start()
    }
    
    func start() {
        tabBarController = BaseTabBarController()
    
        homeCoordinator = HomeFlowController(with: UINavigationController())
        homeCoordinator?.mainViewController?.tabBarItem = UITabBarItem(title: "ACASA", image: UIImage.init(named: "home-unselected"), selectedImage: UIImage.init(named: "home-selected"))
        addChild(coordinator: homeCoordinator!, with: .home)
        
        addJobCoordinator = AddJobFlowController(with: UINavigationController())
        addJobCoordinator?.mainViewController?.tabBarItem = UITabBarItem(title: "ADAUGA JOB", image: UIImage.init(named: "add-unselected"), selectedImage: UIImage.init(named: "add-selected"))
        addChild(coordinator: addJobCoordinator!, with: .addJob)
        
        settingsCoordinator = SettingsFlowController(with: UINavigationController())
        settingsCoordinator?.mainViewController?.tabBarItem = UITabBarItem(title: "ISTORIC", image: UIImage.init(named: "logo-istoric"), selectedImage: UIImage.init(named: "logo-istoric"))
        addChild(coordinator: settingsCoordinator!, with: .settings)
        
        guard
            let home = homeCoordinator?.mainViewController,
            let addJob = addJobCoordinator?.mainViewController,
            let settings = settingsCoordinator?.mainViewController
            else { fatalError("Coordinators need to have a mainViewController") }
        
        tabBarController?.viewControllers = [home, addJob, settings]
    }
}
