//
//  RegisterPageViewModel.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class RegisterPageViewModelDependency {
    // MARK: - Properties
    
    let fetcher: RegisterPageAPIFetcherProtocol
    
    // MARK: - Init
    
    init(fetcher: RegisterPageAPIFetcherProtocol = RegisterPageAPIFetcher()) {
        self.fetcher = fetcher
    }
}

final class RegisterPageViewModel {
    // MARK: - Properties
    
    weak var action: (BaseViewModelAction & RegisterPageViewModelAction)?
    
    var email: String = ""
    var password: String = ""
    var reenterPassword: String = ""
    
    private let dependency: RegisterPageViewModelDependency
    
    // MARK: - Init
    
    init(dependency: RegisterPageViewModelDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public Methods
    
    func register() {
        guard password == reenterPassword else {
            action?.hideLoadingView()
            action?.showBanner(text: "Password and Reenter Password is not match")
            
            return
        }
        
        action?.showLoadingView()
        
        let parameters: [String: String] = [
            "email": email.lowercased(),
            "password": password
        ]
        
        dependency.fetcher.requestAPI(parameters: parameters, onSuccess: { [weak self] response in
            self?.action?.hideLoadingView()
            self?.action?.onRegisterFinish()
        }) { [weak self] error in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError { [weak self] in
                self?.register()
            }
        }
    }
}
