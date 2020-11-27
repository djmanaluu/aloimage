//
//  LoginPageViewModelTest.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import XCTest
@testable import Alodokter_Test_App

final class LoginPageViewModelTest: XCTestCase {
    var apiFetchMock: LoginPageAPIFetcherMock = LoginPageAPIFetcherMock()
    var actionMock: LoginPageViewModelActionMock = LoginPageViewModelActionMock()
    var viewModel: LoginPageViewModel = LoginPageViewModel(dependency: LoginPageViewModelDependency())
    
    func testLogin() {
        // MARK: - Condition: Fetching return 401 status
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { httpStatusCodeHandlerBlock, _, _ in
            _ = httpStatusCodeHandlerBlock(401)
        }
        
        viewModel.login()
        
        // Expectation: Should call handleUnauthorized action
        
        XCTAssertTrue(actionMock.isHandleUnauthorizedCalled)
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isLoginCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { _, successBlock, _ in
            successBlock(LoginResponseMock.getLoginResponseMock())
        }
        
        viewModel.login()
        
        // Expectation: Should call login action
        
        XCTAssertFalse(actionMock.isHandleUnauthorizedCalled)
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertTrue(actionMock.isLoginCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Failed
        
        beforeEach()
        
        apiFetchMock.fetchBlock = { _, _, errorBlock in
            errorBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        viewModel.login()
        
        // Expectation: Should call show error view
        
        XCTAssertFalse(actionMock.isHandleUnauthorizedCalled)
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isLoginCalled)
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    
    // MARK: - Utilities Methods
    
    private func beforeEach() {
        apiFetchMock = LoginPageAPIFetcherMock()
        actionMock = LoginPageViewModelActionMock()
        viewModel = LoginPageViewModel(dependency: LoginPageViewModelDependency(fetcher: apiFetchMock))
        
        viewModel.action = actionMock
    }
}
