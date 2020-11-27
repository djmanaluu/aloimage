//
//  ProfileMocks.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation
@testable import Alodokter_Test_App

final class ProfileAPIFetcherMock: ProfileAPIFetcherProtocol {
    typealias GetProfileAPISuccessBlock = (GetProfileResponse) -> Void
    typealias PostProfileAPISuccessBlock = (PostProfileResponse) -> Void
    typealias LogoutAPISuccessBlock = (ProfileLogout) -> Void
    typealias ErrorBlock = (Error) -> Void
    
    var isGetProfileAPICalled: Bool = false
    var isPostProfileAPICalled: Bool = false
    var isLogoutAPICalled: Bool = false
    
    var getProfileFetchBlock: ((GetProfileAPISuccessBlock, ErrorBlock) -> Void)?
    var postProfileFetchBlock: ((PostProfileAPISuccessBlock, ErrorBlock) -> Void)?
    var logoutFetchBlock: ((LogoutAPISuccessBlock, ErrorBlock) -> Void)?
    
    func getProfile(userID: String, onSuccess: @escaping (GetProfileResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        isGetProfileAPICalled = true
        getProfileFetchBlock?(onSuccess, onFailure)
    }
    
    func postProfile(parameters: [String : String], onSuccess: @escaping (PostProfileResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        isPostProfileAPICalled = true
        postProfileFetchBlock?(onSuccess, onFailure)
    }
    
    func postLogut(userID: String, onSuccess: @escaping (ProfileLogout) -> Void, onFailure: @escaping (Error) -> Void) {
        isLogoutAPICalled = true
        logoutFetchBlock?(onSuccess, onFailure)
    }
}

final class ProfileViewModelActionMock: BaseViewModelAction, ProfileViewModelAction {
    var isShowLoadingViewCalled: Bool = false
    var isHideLoadingViewCalled: Bool = false
    var isShowErrorViewCalled: Bool = false
    var isHideErrorViewCalled: Bool = false
    var isHandleUnauthorizedCalled: Bool = false
    var isLoginCalled: Bool = false
    var isConfigureProfilePageCalled: Bool = false
    var isShowBannerCalled: Bool = false
    
    func showLoadingView() {
        isShowLoadingViewCalled = true
    }
    
    func hideLoadingView() {
        isHideLoadingViewCalled = true
    }
    
    func showNetworkError(retryButtonAction: @escaping (() -> Void)) {
        isShowErrorViewCalled = true
    }
    
    func hideErrorView() {
        isHideErrorViewCalled = true
    }
    
    func handleUnauthorized() {
        isHandleUnauthorizedCalled = true
    }
    
    func login() {
        isLoginCalled = true
    }
    
    func configureProfilePage() {
        isConfigureProfilePageCalled = true
    }
    
    func showBanner(text: String) {
        isShowBannerCalled = true
    }
}

final class ProfileResponseMock {
    static func getProfileResponseMock() -> GetProfileResponse {
        let responseDict: [String: String] = [
            "name": "NAME",
            "gender": "GENDER",
            "phoneNumber": "PHONE_NUMBER"
        ]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(GetProfileResponse.self, from: data)
    }
    
    static func postProfileResponseMock() -> PostProfileResponse {
        let responseDict: [String: String] = [
            "token": "TOKEN_MOCK",
            "userID": "USER_ID_MOCK"
        ]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(PostProfileResponse.self, from: data)
    }
    
    static func logoutResponseMock() -> ProfileLogout {
        let responseDict: [String: String] = [
            "token": "TOKEN_MOCK",
            "userID": "USER_ID_MOCK"
        ]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(ProfileLogout.self, from: data)
    }
}
