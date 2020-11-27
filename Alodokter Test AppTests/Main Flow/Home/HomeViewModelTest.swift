//
//  HomeViewModelTest.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import XCTest
@testable import Alodokter_Test_App

final class HomeViewModelTest: XCTestCase {
    var apiFetchMock: HomeAPIFetcherMock = HomeAPIFetcherMock()
    var actionMock: HomeViewModelActionMock = HomeViewModelActionMock()
    var viewModel: HomeViewModel = HomeViewModel(dependency: HomeViewModelDependency())
    
    func testLoadContents() {
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { successBlock, _ in
            successBlock(HomeResponseMock.getHomeResponseMock())
        }
        
        viewModel.loadContents()
        
        // Expectation: Should call configureHome action
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertTrue(actionMock.isConfigureHomeCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { _, errorBlock in
            errorBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        viewModel.loadContents()
        
        // Expectation: Should call configureHome action
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isConfigureHomeCalled)
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    
    // MARK: - Utilities Methods
    
    private func beforeEach() {
        apiFetchMock = HomeAPIFetcherMock()
        actionMock = HomeViewModelActionMock()
        viewModel = HomeViewModel(dependency: HomeViewModelDependency(fetcher: apiFetchMock))
        
        viewModel.action = actionMock
    }
}
