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
    
    var email: String = ""
    var password: String = ""
    var reenterPassword: String = ""
    
    private let dependency: RegisterPageViewModelDependency
    
    // MARK: - Init
    
    init(dependency: RegisterPageViewModelDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public Methods
    
    func onRegisterButtonTapped() {
        
    }
}
