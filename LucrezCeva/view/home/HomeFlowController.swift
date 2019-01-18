//
//  HomeFlowController.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/12/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import UIKit

class HomeFlowController: Coordinator {
    
    var mainViewController: UIViewController?
    var childCoordinators: [Constants.CoordinatorKeys : Coordinator]
    
    init(with navigationController: UINavigationController) {
        self.mainViewController = navigationController
        self.childCoordinators = [:]
        
        start()
    }
    
    func start() {
        let viewController = HomeViewController.instantiate()
        let viewModel = HomeViewModel()
        viewController.delegate = self
        viewController.viewModel = viewModel
        setRoot(to: viewController)
    }
}

extension HomeFlowController: HomeDelegate {
    func jobCellTapped(job: JobItem) {
        let viewController = DetailsJobViewController.instantiate()
        let viewModel = DetailsJobViewModel(job.id!)
        viewController.viewModel = viewModel
        navigate(to: viewController, with: .push)
        
    }
    
}
