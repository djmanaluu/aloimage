//
//  ProfileResponse.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

final class GetProfileResponse: Codable {
    // MARK: - Properties
    
    var name: String
    var gender: String
    var phoneNumber: String
    
    // MARK: - Static Methods
    
    static func getProfile(userID: String,
                           onSuccess: @escaping (GetProfileResponse) -> Void,
                           onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.userProfile.urlString + "/\(userID)",
                            responseType: GetProfileResponse.self,
                            httpMethod: .get,
                            parameters: nil,
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

final class ProfileLogout: Codable {
    // MARK: - Static Methods
    
    static func postProfile(userID: String,
                            onSuccess: @escaping (ProfileLogout) -> Void,
                            onFailure: @escaping (Error) -> Void) {
        NetworkUtil.request(from: APIEndPoints.logout.urlString + "/\(userID)",
                            responseType: ProfileLogout.self,
                            httpMethod: .post,
                            parameters: nil,
                            onSuccess: onSuccess,
                            onFailure: onFailure)
    }
}

protocol ProfileAPIFetcherProtocol {
    func getProfile(userID: String,
                    onSuccess: @escaping (GetProfileResponse) -> Void,
                    onFailure: @escaping(Error) -> Void)
    
    func postProfile(parameters: [String: String],
                     onSuccess: @escaping (PostProfileResponse) -> Void,
                     onFailure: @escaping(Error) -> Void)
    
    func postLogut(userID: String,
                   onSuccess: @escaping (ProfileLogout) -> Void,
                   onFailure: @escaping(Error) -> Void)
}

final class ProfileAPIFetcher: ProfileAPIFetcherProtocol {
    func getProfile(userID: String,
                    onSuccess: @escaping (GetProfileResponse) -> Void,
                    onFailure: @escaping(Error) -> Void) {
        GetProfileResponse.getProfile(userID: userID,
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
    
    func postLogut(userID: String,
                   onSuccess: @escaping (ProfileLogout) -> Void,
                   onFailure: @escaping(Error) -> Void) {
        ProfileLogout.postProfile(userID: userID,
                                  onSuccess: onSuccess,
                                  onFailure: onFailure)
    }
}
