//
//  Auth.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation

private let kCurrentToken: String = "API_CURRENT_TOKEN"

final class Auth {
    static var token: String? {
        get {
            UserDefaults.standard.string(forKey: kCurrentToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kCurrentToken)
        }
    }
    
    static var isTokenAvailable: Bool {
        return token != nil
    }
    
    static func userLogout(completion: (() -> Void)? = nil) {
        token = nil
        completion?()
    }
}
