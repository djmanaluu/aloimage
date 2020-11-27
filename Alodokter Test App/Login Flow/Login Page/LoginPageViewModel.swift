//
//  LoginPageViewModel.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation

final class LoginPageViewModelDependency {
    // MARK: - Properties
    
    let fetcher: LoginPageAPIFetcherProtocol
    
    // MARK: - Init
    
    init(fetcher: LoginPageAPIFetcherProtocol = LoginPageAPIFetcher()) {
        self.fetcher = fetcher
    }
}

final class LoginPageViewModel {
    // MARK: - Properties
    
    weak var action: (BaseViewModelAction & LoginPageViewModelAction)?
    
    var email: String = ""
    var password: String = ""
    
    private let dependency: LoginPageViewModelDependency
    
    // MARK: - Init
    
    init(dependency: LoginPageViewModelDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public Methods
    
    func login() {
        let emailPasswordCombinationString: String = "\(email.lowercased()):\(password)"
        let emailPasswordCombinationData: Data = Data(emailPasswordCombinationString.utf8)
        let basicAuthValueString: String = emailPasswordCombinationData.base64EncodedString()
        let basicAuthHeaderValue: String = "Basic " + basicAuthValueString
        let header: [String: String] = ["Authorization": basicAuthHeaderValue]
        
        action?.showLoadingView()
        
        dependency.fetcher.requestAPI(header: header, httpStatusCodeHandler: { [weak self] httpStatusCode -> Bool in
            self?.action?.hideLoadingView()
            
            if httpStatusCode == 401 {
                self?.action?.handleUnauthorized()
                
                return true
            }
            
            return false
            
            }, onSuccess: { [weak self] response in
                self?.action?.hideLoadingView()
                
                Auth.token = response.token
                Auth.userID = response.userID
                
                self?.action?.login()
        }) { [weak self] _ in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError { [weak self] in
                self?.login()
            }
        }
    }
}
