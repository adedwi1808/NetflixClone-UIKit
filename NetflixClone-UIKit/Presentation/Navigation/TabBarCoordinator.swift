//
//  TabBarCoordinator.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 24/05/24.
//

import UIKit

enum TabBarPage {
    case home
    case search
    case favorite

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .search
        case 2:
            self = .favorite
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .favorite:
            return "Favorite"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .search:
            return 1
        case .favorite:
            return 2
        }
    }

    func icon() -> String {
        switch self {
        case .home:
            return "house"
        case .search:
            return "magnifyingglass"
        case .favorite:
            return "star"
        }
    }
    
    // Add tab icon selected / deselected color
    
    // etc
}

class TabBarCoordinator: Coordinator {
    var childCoordinators: [any Coordinator]
    
    var navigationController: UINavigationController
    
    private var tabBarController: MainTabBarViewController
    
    init(
        childCoordinators: [any Coordinator] = [],
        navigationController: UINavigationController
    ) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.tabBarController = MainTabBarViewController()
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .search, .favorite]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        var navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: UIImage(systemName: page.icon()),
                                                     tag: page.pageOrderNumber())

        switch page {
        case .home:
            let homeCoordinator = HomeCoordinator(navigationController: navController)
            homeCoordinator.start()
            childCoordinators.append(homeCoordinator)
            navController = homeCoordinator.navigationController
        case .search:
            let searchVC = SearchViewController()
                        
            navController.pushViewController(searchVC, animated: true)
        case .favorite:
            let favoriteVC = FavoriteViewController()
                        
            navController.pushViewController(favoriteVC, animated: true)
        }
        
        return navController
    }
}
