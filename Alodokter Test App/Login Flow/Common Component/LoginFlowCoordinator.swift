//
//  LoginFlowCoordinator.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class LoginFlowCoordinator: Coordinator {
    // MARK: - Properties
    
    var parentCoordinator: Coordinator?
    
    var type: CoordinatorType { return .login }
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func start() {
        let loginPageVC: LoginPageViewController = LoginPageViewController.constructController()
        
        loginPageVC.coordinator = self
        
        navigationController.setViewControllers([loginPageVC], animated: navigationController.viewControllers.count > 0)
    }
    
    func navigateToRegisterPage() {
        let registerPageVC: RegisterPageViewController = RegisterPageViewController.constructController()
        
        registerPageVC.coordinator = self
        
        navigationController.pushViewController(registerPageVC, animated: true)
    }
}
