//
//  TabbarCoordinator.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

enum TabbarPage {
    case home
    case profile
    
    func tabbarIndex() -> Int {
        switch self {
        case .home:
            return 0
        case .profile:
            return 1
        }
    }
    
    func pageTitle() -> String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        }
    }
    
    func icon() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "ic-home")
        case .profile:
            return UIImage(named: "ic-profile")
        }
    }
}

final class TabbarCoordinator: NSObject, Coordinator {
    // MARK: - Properties
    
    var parentCoordinator: Coordinator?
    
    var type: CoordinatorType { .tabbar }
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabbarController: UITabBarController = UITabBarController()
    
    // MARK: - Init
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func start() {
        let controllers: [UINavigationController] = [getTabNavigationController(.home), getTabNavigationController(.profile)]
        
        prepareTabbarController(withViewControllers: controllers)
    }
    
    // MARK: - Public Methods
    
    func selectPage(_ page: TabbarPage) {
        tabbarController.selectedIndex = page.tabbarIndex()
    }
    
    // MARK: - Private Methods
    
    private func prepareTabbarController(withViewControllers viewControllers: [UIViewController]) {
        tabbarController.setViewControllers(viewControllers, animated: true)
        tabbarController.selectedIndex = TabbarPage.home.tabbarIndex()
        tabbarController.tabBar.isTranslucent = false
        
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.viewControllers = [tabbarController]
    }
    
    private func getTabNavigationController(_ page: TabbarPage) -> UINavigationController {
        let navigationController: UINavigationController = UINavigationController()
        
        navigationController.tabBarItem = UITabBarItem(title: page.pageTitle(), image: page.icon(), tag: page.tabbarIndex())
        navigationController.setNavigationBarHidden(false, animated: true)
        
        switch page {
        case .home:
            let viewController: HomeViewController = HomeViewController()
            
            navigationController.pushViewController(viewController, animated: true)
            
            break
        case .profile:
            let viewController: ProfileViewController = ProfileViewController.constructController()
            
            navigationController.pushViewController(viewController, animated: true)
            
            break
        }
        
        return navigationController
    }
}
