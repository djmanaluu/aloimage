//
//  Coordinator.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

enum CoordinatorType {
    case app
    case login
    case tabbar
}

protocol Coordinator: AnyObject {
    // MARK: - Properties
    
    var type: CoordinatorType { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    // MARK: - Methods
    
    func start()
    func finish()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        parentCoordinator?.childDidFinish(self)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
