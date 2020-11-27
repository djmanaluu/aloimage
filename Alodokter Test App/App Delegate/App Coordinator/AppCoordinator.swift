//
//  AppCoordinator.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: - Properties
    
    static var shared: AppCoordinator = AppCoordinator()
    
    var type: CoordinatorType { return .app }
    
    var parentCoordinator: Coordinator? = nil
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    // MARK: - Init
    
    init() {
        navigationController = UINavigationController()
    }
    
    // MARK: -  Coordinator
    
    func start() {
        childCoordinators = []
        Auth.isTokenAvailable ? openMainFlow() : openLogInFlow()
    }
    
    func openLogInFlow() {
        navigationController.viewControllers.removeAll()
        
        let child: LoginFlowCoordinator = LoginFlowCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        childCoordinators.append(child)
        child.start()
    }
    
    func openMainFlow() {
        navigationController.viewControllers.removeAll()
        
        let child: TabbarCoordinator = TabbarCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        childCoordinators.append(child)
        child.start()
    }
    
    func logout() {
        childCoordinators = []
        openLogInFlow()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        childCoordinators = childCoordinators.filter({ $0 !== child })
        
        switch child?.type {
        case .login:
            openMainFlow()
            break
        case .tabbar:
            openLogInFlow()
            break
        default:
            break
        }
    }
}
