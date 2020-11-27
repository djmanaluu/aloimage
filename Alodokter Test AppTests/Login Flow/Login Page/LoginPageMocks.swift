//
//  LoginPageMocks.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation
@testable import Alodokter_Test_App

final class LoginPageAPIFetcherMock: LoginPageAPIFetcherProtocol {
    typealias HTTPStatusCodeHandlerBlock = (Int) -> Bool
    typealias SuccessBlock = (LoginPageResponse) -> Void
    typealias ErrorBlock = (Error) -> Void
    
    var isCallAPICalled: Bool = false
    var fetchBlock: ((HTTPStatusCodeHandlerBlock, SuccessBlock, ErrorBlock) -> Void)?
    
    func requestAPI(header: [String : String], httpStatusCodeHandler: @escaping (Int) -> Bool, onSuccess: @escaping (LoginPageResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        isCallAPICalled = true
        
        fetchBlock?(httpStatusCodeHandler, onSuccess, onFailure)
    }
}

final class LoginPageViewModelActionMock: BaseViewModelAction, LoginPageViewModelAction {
    var isShowLoadingViewCalled: Bool = false
    var isHideLoadingViewCalled: Bool = false
    var isShowErrorViewCalled: Bool = false
    var isHideErrorViewCalled: Bool = false
    var isHandleUnauthorizedCalled: Bool = false
    var isLoginCalled: Bool = false
    
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
}

final class LoginResponseMock {
    static func getLoginResponseMock() -> LoginPageResponse {
        let responseDict: [String: String] = [
            "token": "TOKEN_MOCK",
            "userID": "USER_ID_MOCK"
        ]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(LoginPageResponse.self, from: data)
    }
}
