//
//  HomeMocks.swift
//  Alodokter Test AppTests
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation
@testable import Alodokter_Test_App

final class HomeAPIFetcherMock: HomeAPIFetcherProtocol {
    typealias SuccessBlock = (HomeResponse) -> Void
    typealias ErrorBlock = (Error) -> Void
    
    var isCallAPICalled: Bool = false
    var fetchBlock: ((SuccessBlock, ErrorBlock) -> Void)?
    
    func request(onSuccess: @escaping (HomeResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        isCallAPICalled = true
        fetchBlock?(onSuccess, onFailure)
    }
}

final class HomeViewModelActionMock: BaseViewModelAction, HomeViewModelAction {
    var isShowLoadingViewCalled: Bool = false
    var isHideLoadingViewCalled: Bool = false
    var isShowErrorViewCalled: Bool = false
    var isHideErrorViewCalled: Bool = false
    var isConfigureHomeCalled: Bool = false
    
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
    
    func configureHome() {
        isConfigureHomeCalled = true
    }
}

final class HomeResponseMock {
    static func getHomeResponseMock() -> HomeResponse {
        let responseDict: [String: Any] = [
            "imageAlbums": [
                [
                    ["imageUrl": "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2018/08/kitten-440379.jpg"],
                    ["imageUrl": "https://ichef.bbci.co.uk/news/1024/cpsprodpb/151AB/production/_111434468_gettyimages-1143489763.jpg"],
                    ["imageUrl": "https://icatcare.org/app/uploads/2018/07/Thinking-of-getting-a-cat.png"],
                ],
                [
                    ["imageUrl": "https://static.toiimg.com/thumb/msid-67586673,width-800,height-600,resizemode-75,imgsize-3918697,pt-32,y_pad-40/67586673.jpg"],
                    ["imageUrl": "https://images.theconversation.com/files/350865/original/file-20200803-24-50u91u.jpg"],
                    ["imageUrl": "https://static.scientificamerican.com/sciam/cache/file/92E141F8-36E4-4331-BB2EE42AC8674DD3_source.jpg"],
                ],
                [
                    ["imageUrl": "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_relaxing_on_patio_other/1800x1200_cat_relaxing_on_patio_other.jpg"],
                    ["imageUrl": "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/kitten-510651.jpg"],
                    ["imageUrl": "https://cdnuploads.aa.com.tr/uploads/Contents/2020/05/14/thumbs_b_c_88bedbc66bb57f0e884555e8250ae5f9.jpg"],
                ]
            ]
        ]
        let data: Data = try! JSONSerialization.data(withJSONObject: responseDict, options: .prettyPrinted)
        
        return try! JSONDecoder().decode(HomeResponse.self, from: data)
    }
}

