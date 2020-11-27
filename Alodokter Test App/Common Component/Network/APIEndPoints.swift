//
//  Endpoints.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

private let host: String = "http://aloimage-api.herokuapp.com"

enum APIEndPoints: String {
    case login = "/api/users/login"
    case logout = "/api/users/logout"
    case register = "/api/users/register"
    
    case getContents = "/api/contents"
    
    case userProfile = "/api/profile"
    
    var urlString: String {
        return host + rawValue
    }
}
