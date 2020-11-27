//
//  Auth.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation

private let kCurrentToken: String = "API_CURRENT_TOKEN"
private let kCurrentUserID: String = "API_CURRENT_USER_ID"

final class Auth {
    // MARK: - Properties
    
    static var token: String? {
        get {
            UserDefaults.standard.string(forKey: kCurrentToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kCurrentToken)
        }
    }
    
    static var userID: String? {
        get {
            UserDefaults.standard.string(forKey: kCurrentUserID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kCurrentUserID)
        }
    }
    
    static var isTokenAvailable: Bool {
        return token != nil
    }
    
    // MARK: - Static Methods
    
    static func userLogout(completion: (() -> Void)? = nil) {
        token = nil
        
        AppCoordinator.shared.logout()
        
        completion?()
    }
}
