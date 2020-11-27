//
//  ResgisterPageViewModelTest.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import XCTest
@testable import Alodokter_Test_App

final class RegisterPageViewModelTest: XCTestCase {
    var apiFetchMock: RegisterPageAPIFetcherMock = RegisterPageAPIFetcherMock()
    var actionMock: RegisterPageViewModelActionMock = RegisterPageViewModelActionMock()
    var viewModel: RegisterPageViewModel = RegisterPageViewModel(dependency: RegisterPageViewModelDependency())
    
    func testRegister() {
        // MARK: - Condition: Password and Reenter Password is not matching
        
        beforeEach()
        
        viewModel.password = "A"
        viewModel.reenterPassword = "B"
        
        viewModel.register()
        
        // Expectation: Should show banner
        
        XCTAssertTrue(actionMock.isShowBannerCalled)
        
        
        
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { successBlock, _ in
            successBlock(RegisterResponseMock.getRegisterResponseMock())
        }
        
        // Call Register method
        
        viewModel.register()
        
        // Expectation: should call On Register Finish
        
        XCTAssertTrue(actionMock.isOnRegisterFinishCalled)
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { _, failureBlock in
            failureBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        // Call Register method
        
        viewModel.register()
        
        // Expectation: should call show error view
        
        XCTAssertFalse(actionMock.isOnRegisterFinishCalled)
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    // MARK: - Utilities Methods
    
    private func beforeEach() {
        apiFetchMock = RegisterPageAPIFetcherMock()
        actionMock = RegisterPageViewModelActionMock()
        viewModel = RegisterPageViewModel(dependency: RegisterPageViewModelDependency(fetcher: apiFetchMock))
        
        viewModel.action = actionMock
    }
}
