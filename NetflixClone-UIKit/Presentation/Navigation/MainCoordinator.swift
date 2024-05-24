//
//  MainCoordinator.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators: [any Coordinator]
    
    var navigationController: UINavigationController
    
    init(
        childCoordinators: [any Coordinator] = [],
        navigationController: UINavigationController
    ) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        childCoordinators.append(mainTabBarCoordinator)
        mainTabBarCoordinator.start()
    }
}
