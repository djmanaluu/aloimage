//
//  RegisterPageMocks.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation
@testable import Alodokter_Test_App

final class RegisterPageAPIFetcherMock: RegisterPageAPIFetcherProtocol {
    typealias SuccessBlock = (RegisterPageResponse) -> Void
    typealias ErrorBlock = (Error) -> Void
    
    var isCallAPICalled: Bool = false
    var fetchBlock: ((SuccessBlock, ErrorBlock) -> Void)?
    
    func requestAPI(parameters: [String : Any], onSuccess: @escaping (RegisterPageResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        fetchBlock?(onSuccess, onFailure)
    }
}

final class RegisterPageViewModelActionMock: BaseViewModelAction, RegisterPageViewModelAction {
    var isShowLoadingViewCalled: Bool = false
    var isHideLoadingViewCalled: Bool = false
    var isShowErrorViewCalled: Bool = false
    var isHideErrorViewCalled: Bool = false
    var isShowBannerCalled: Bool = false
    var isOnRegisterFinishCalled: Bool = false
    
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
    
    func showBanner(text: String) {
        isShowBannerCalled = true
    }
    
    func onRegisterFinish() {
        isOnRegisterFinishCalled = true
    }
}

final class RegisterResponseMock {
    static func getRegisterResponseMock() -> RegisterPageResponse {
        let responseDict: [String: String] = [:]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(RegisterPageResponse.self, from: data)
    }
}
