//
//  RegisterPageResponse.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class RegisterPageResponse: Codable {
   // MARK: - Static Methods
    
    static func request(parameters: [String: Any], onSuccess: @escaping (RegisterPageResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.register.urlString,
                            responseType: self,
                            httpMethod: .post,
                            parameters: parameters,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

protocol RegisterPageAPIFetcherProtocol {
    func requestAPI(parameters: [String: Any],
                    onSuccess: @escaping (RegisterPageResponse) -> Void,
                    onFailure: @escaping (Error) -> Void)
}

final class RegisterPageAPIFetcher: RegisterPageAPIFetcherProtocol {
    func requestAPI(parameters: [String: Any],
                    onSuccess: @escaping (RegisterPageResponse) -> Void,
                    onFailure: @escaping (Error) -> Void) {
        RegisterPageResponse.request(parameters: parameters,
                                     onSuccess: onSuccess,
                                     onFailure: onFailure)
    }
}
