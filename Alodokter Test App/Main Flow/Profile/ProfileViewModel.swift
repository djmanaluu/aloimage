//
//  ProfileViewModel.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation

final class ProfileViewModelDependency {
    // MARK: - Properties
    
    let fetcher: ProfileAPIFetcherProtocol
    
    // MARK: - Init
    
    init(fetcher: ProfileAPIFetcherProtocol = ProfileAPIFetcher()) {
        self.fetcher = fetcher
    }
}

final class ProfileViewModel {
    // MARK: - Properties
    
    weak var action: (BaseViewModelAction & ProfileViewModelAction)?
    
    var name: String = ""
    var gender: String = ""
    var phoneNumber: String = ""
    
    private let dependency: ProfileViewModelDependency
    
    // MARK: - Init
    
    init(dependency: ProfileViewModelDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public Methods
    
    func getProfile() {
        action?.showLoadingView()
        
        dependency.fetcher.getProfile(userID: Auth.userID ?? "", onSuccess: { [weak self] (response) in
            self?.name = response.name
            self?.gender = response.gender
            self?.phoneNumber = response.phoneNumber
            
            self?.action?.hideLoadingView()
            self?.action?.configureProfilePage()
            self?.action?.setupPickerView()
        }) { [weak self] error in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError { [weak self] in
                self?.getProfile()
            }
        }
    }
    
    func updateProfile() {
        action?.showLoadingView()
        
        let parameters: [String: String] = [
            "name": name,
            "gender": gender,
            "phoneNumber": phoneNumber,
            "userID": Auth.userID ?? ""
        ]
        
        dependency.fetcher.postProfile(parameters: parameters, onSuccess: { [weak self] response in
            self?.action?.hideLoadingView()
            self?.action?.showBanner(text: "Update Successs")
        }) { [weak self] _ in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError { [weak self] in
                self?.updateProfile()
            }
        }
    }
    
    func logout(didFinish: @escaping () -> Void) {
        action?.showLoadingView()
        
        dependency.fetcher.postLogut(userID: Auth.userID ?? "", onSuccess: { [weak self] _ in
            self?.action?.hideLoadingView()
            didFinish()
        }) { [weak self] error in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError {
                self?.logout(didFinish: didFinish)
            }
        }
    }
}
