//
//  HomeViewModel.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class HomeViewModelDependency {
    // MARK: - Properties
    
    let fetcher: HomeAPIFetcherProtocol
    
    // MARK: - Init
    
    init(fetcher: HomeAPIFetcherProtocol = HomeAPIFetcher()) {
        self.fetcher = fetcher
    }
}

final class HomeViewModel {
    // MARK: - Properties
    
    weak var action: (BaseViewModelAction & HomeViewModelAction)?
    
    var response: HomeResponse? {
        didSet {
            action?.configureHome()
        }
    }
    
    private let dependency: HomeViewModelDependency
    
    // MARK: - Init
    
    init(dependency: HomeViewModelDependency) {
        self.dependency = dependency
    }
    
    // MARK: - Public Methods
    
    func loadContents() {
        action?.showLoadingView()
        
        dependency.fetcher.request(onSuccess: { [weak self] response in
            self?.action?.hideLoadingView()
            self?.response = response
        }) { [weak self] _ in
            self?.action?.hideLoadingView()
            self?.action?.showNetworkError {
                self?.loadContents()
            }
        }
    }
}
