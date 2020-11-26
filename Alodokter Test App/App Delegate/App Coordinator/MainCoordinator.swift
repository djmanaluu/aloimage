//
//  MainCoordinator.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: - Properties
    
    static var shared: MainCoordinator = MainCoordinator()
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init() {
        navigationController = UINavigationController()
    }
    
    // MARK: -  Coordinator
    
    func start() {
        childCoordinators = []
        Auth.isTokenAvailable ? openHomeFlow() : openLogInFlow()
    }
    
    func openLogInFlow() {
        let child: LoginFlowCoordinator = LoginFlowCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        childCoordinators.append(child)
        child.start()
    }
    
    func openHomeFlow() {
        
    }
}
