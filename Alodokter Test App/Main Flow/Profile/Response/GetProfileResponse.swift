//
//  ProfileResponse.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class GetProfileResponse: Codable {
    // MARK: - Properties
    
    var profileImageData: String
    var name: String
    var gender: String
    var phoneNumber: String
    
    // MARK: - Static Methods
    
    static func getProfile(parameters: [String: String],
                           onSuccess: @escaping (GetProfileResponse) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.userProfile.urlString,
                            responseType: GetProfileResponse.self,
                            httpMethod: .get,
                            parameters: parameters,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

final class PostProfileResponse: Codable {
    // MARK: - Static Methods
    
    static func postProfile(parameters: [String: String],
                            onSuccess: @escaping (PostProfileResponse) -> Void,
                            onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.userProfile.urlString,
                            responseType: PostProfileResponse.self,
                            httpMethod: .post,
                            parameters: parameters,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

protocol ProfileAPIFetcherProtocol {
    func getProfile(parameters: [String: String],
                    onSuccess: @escaping (GetProfileResponse) -> Void,
                    onFailure: @escaping(Error) -> Void)
    
    func postProfile(parameters: [String: String],
                     onSuccess: @escaping (PostProfileResponse) -> Void,
                     onFailure: @escaping(Error) -> Void)
}

final class ProfileAPIFetcher: ProfileAPIFetcherProtocol {
    func getProfile(parameters: [String: String],
                    onSuccess: @escaping (GetProfileResponse) -> Void,
                    onFailure: @escaping(Error) -> Void) {
        GetProfileResponse.getProfile(parameters: parameters,
                                      onSuccess: onSuccess,
                                      onFailure: onFailure)
    }
    
    func postProfile(parameters: [String: String],
                     onSuccess: @escaping (PostProfileResponse) -> Void,
                     onFailure: @escaping(Error) -> Void) {
        PostProfileResponse.postProfile(parameters: parameters,
                                        onSuccess: onSuccess,
                                        onFailure: onFailure)
    }
}
