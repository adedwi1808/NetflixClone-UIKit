//
//  HomeCoordinator.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [any Coordinator]
    
    var navigationController: UINavigationController
    
    init(childCoordinators: [any Coordinator] = [], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let services: HomeServicesProtocol = HomeServices()
        let viewModel: HomeViewModelProtocol = HomeViewModel(services: services)
        let viewController: HomeViewController = HomeViewController(viewModel: viewModel)
        viewController.coordinator = self
        
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
