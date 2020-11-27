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
    
    weak var action: (BaseViewModelAction & ProfileContracts)?
    
    var profileImageData: Data?
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
        
        let parameters: [String: String] = [
            "userID": Auth.userID ?? "",
        ]
        
        dependency.fetcher.getProfile(parameters: parameters, onSuccess: { [weak self] (response) in
            self?.profileImageData = Data(response.profileImageData.utf8)
            self?.name = response.name
            self?.gender = response.gender
            self?.phoneNumber = response.phoneNumber
            
            self?.action?.hideLoadingView()
            self?.action?.configureProfilePage()
        }) { [weak self] _ in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError { [weak self] in
                self?.getProfile()
            }
        }
    }
    
    func updateProfile() {
        action?.showLoadingView()
        
        let imageDataString: String
        
        if let profileImageData: Data = profileImageData {
            imageDataString = String(decoding: profileImageData, as: UTF8.self)
        }
        else {
            imageDataString = ""
        }
        
        let parameters: [String: String] = [
            "profileImageData": imageDataString,
            "name": name,
            "gender": gender,
            "phoneNumber": phoneNumber
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
}
