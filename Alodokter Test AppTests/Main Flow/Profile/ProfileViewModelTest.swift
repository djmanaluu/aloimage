//
//  ProfileViewModelTest.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import XCTest
@testable import Alodokter_Test_App

final class ProfileViewModelTest: XCTestCase {
    var apiFetchMock: ProfileAPIFetcherMock = ProfileAPIFetcherMock()
    var actionMock: ProfileViewModelActionMock = ProfileViewModelActionMock()
    var viewModel: ProfileViewModel = ProfileViewModel(dependency: ProfileViewModelDependency())
    
    func testGetProfile() {
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.getProfileFetchBlock = { successBlock, _ in
            successBlock(ProfileResponseMock.getProfileResponseMock())
        }
        
        viewModel.getProfile()
        
        // Expectation: Should call Configure Page
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertTrue(actionMock.isConfigureProfilePageCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Failed
        
        beforeEach()
        
        apiFetchMock.getProfileFetchBlock = { _, errorBlock in
            errorBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        viewModel.getProfile()
        
        // Expectation: Should call Show error
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isConfigureProfilePageCalled)
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    
    func testUpdateProfile() {
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.postProfileFetchBlock = { successBlock, _ in
            successBlock(ProfileResponseMock.postProfileResponseMock())
        }
        
        viewModel.updateProfile()
        
        // Expectation: Should call login
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertTrue(actionMock.isShowBannerCalled)
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Failed
        
        beforeEach()
        
        apiFetchMock.postProfileFetchBlock = { _, errorBlock in
            errorBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        viewModel.updateProfile()
        
        // Expectation: Should call login
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertFalse(actionMock.isShowBannerCalled)
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    
    func testLogout() {
        var expectationText: String = ""
        
        // MARK: - Condition: Fetching Success
        
        beforeEach()
        
        apiFetchMock.logoutFetchBlock = { successBlock, _ in
            successBlock(ProfileResponseMock.logoutResponseMock())
        }
        
        viewModel.logout {
            expectationText = "A"
        }
        
        // Expectation: Should call login
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertEqual(expectationText, "A")
        XCTAssertFalse(actionMock.isShowErrorViewCalled)
        
        
        
        // MARK: - Condition: Fetching Failed
        
        beforeEach()
        
        apiFetchMock.logoutFetchBlock = { _, errorBlock in
            errorBlock(NSError(domain: "", code: 404, userInfo: nil))
        }
        
        viewModel.logout {
            expectationText = "B"
        }
        
        // Expectation: Should call login
        
        XCTAssertTrue(actionMock.isHideLoadingViewCalled)
        XCTAssertNotEqual(expectationText, "B")
        XCTAssertTrue(actionMock.isShowErrorViewCalled)
    }
    
    // MARK: - Utilities Methods
    
    private func beforeEach() {
        apiFetchMock = ProfileAPIFetcherMock()
        actionMock = ProfileViewModelActionMock()
        viewModel = ProfileViewModel(dependency: ProfileViewModelDependency(fetcher: apiFetchMock))
        
        viewModel.action = actionMock
    }
}
