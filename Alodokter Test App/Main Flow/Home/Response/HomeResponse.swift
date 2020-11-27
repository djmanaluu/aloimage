//
//  HomeResponse.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class HomeResponse: Codable {
    // MARK: - Properties
    
    let imageAlbums: [[ImageContent]]
    
    // MARK: - Static Methods
    
    static func request(onSuccess: @escaping (HomeResponse) -> Void,
                        onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.getContents.urlString,
                            responseType: HomeResponse.self,
                            httpMethod: .get,
                            parameters: nil,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

struct ImageContent: Codable {
    // MARK: - Properties
    
    let imageUrl: String
}

protocol HomeAPIFetcherProtocol {
    func request(onSuccess: @escaping (HomeResponse) -> Void,
                 onFailure: @escaping (Error) -> Void)
}

final class HomeAPIFetcher: HomeAPIFetcherProtocol {
    func request(onSuccess: @escaping (HomeResponse) -> Void,
                 onFailure: @escaping (Error) -> Void) {
        HomeResponse.request(onSuccess: onSuccess,
                             onFailure: onFailure)
    }
}
