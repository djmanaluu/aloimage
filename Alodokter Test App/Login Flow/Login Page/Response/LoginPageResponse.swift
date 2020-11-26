//
//  LoginPageResponse.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class LoginPageResponse: Codable {
    // MARK: - Properties
    
    var token: String
    var userID: String
    
    // MARK: - Static Methods
    
    static func request(header: [String: String], httpStatusCodeHandler: @escaping (Int) -> Bool, onSuccess: @escaping (LoginPageResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.login.urlString,
                            responseType: self,
                            httpMethod: .post,
                            parameters: nil,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

protocol LoginPageAPIFetcherProtocol {
    func requestAPI(header: [String: String],
                    httpStatusCodeHandler: @escaping (Int) -> Bool,
                    onSuccess: @escaping (LoginPageResponse) -> Void,
                    onFailure: @escaping (Error) -> Void)
}

final class LoginPageAPIFetcher: LoginPageAPIFetcherProtocol {
    func requestAPI(header: [String: String],
                    httpStatusCodeHandler: @escaping (Int) -> Bool,
                    onSuccess: @escaping (LoginPageResponse) -> Void,
                    onFailure: @escaping (Error) -> Void) {
        LoginPageResponse.request(header: header,
                                  httpStatusCodeHandler: httpStatusCodeHandler,
                                  onSuccess: onSuccess,
                                  onFailure: onFailure)
    }
}
