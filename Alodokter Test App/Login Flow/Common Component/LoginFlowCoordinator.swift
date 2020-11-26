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
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init(parentCoordinator: MainCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator
    
    func start() {
        let loginPageVC: LoginPageViewController = LoginPageViewController()
        
        
    }
}
