//
//  NetworkUtil.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import Foundation

final class NetworkUtil {
    enum HTTPMethod {
        case get
        case post
        case put
        case patch
        case delete
        
        var toString: String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .patch:
                return "PATCH"
            case .delete:
                return "DELETE"
            }
        }
    }
    
    /// Create Request with specific URL of the Endpoint, the httpMethod and parameters.
    ///
    /// - Parameters:
    ///   - urlString: API Endpoint
    ///   - httpMethod: HTTP Method (`.get`, `.post`, `.put`, `.patch`, `.delete`)
    ///   - parameters: Dictionary of the parameters (request dictionary)
    ///   - onSuccess: Block for success action
    ///   - onFailure: Block for failed action
    ///
    /// - Returns: Session Data Task of the request (URLSessionDataTask)
    @discardableResult
    static func request<T: Decodable>(from urlString: String,
                                      responseType: T.Type,
                                      httpMethod: HTTPMethod?,
                                      header: [String: String] = [:],
                                      parameters: [String: Any]?,
                                      httpStatusCodeHandler: ((Int) -> Bool)? = nil,
                                      onSuccess: @escaping (T) -> Void,
                                      onFailure: @escaping (Error) -> Void) -> URLSessionDataTask? {
        guard let url: URL = URL(string: urlString) else { return nil }
        
        let session: URLSession = URLSession(configuration: .default)
        var urlRequest: URLRequest = URLRequest(url: url)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = httpMethod?.toString
        
        for key in header.keys {
            if let value:  String = header[key] {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if !header.keys.contains("Authorization"), let token: String = Auth.token {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        
        if let parameters: [String: Any] = parameters, let parametersData: Data = try? JSONSerialization.data(withJSONObject: parameters) {
            urlRequest.httpBody = parametersData
        }
        
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                    if let httpStatusCodeHandler: (Int) -> Bool = httpStatusCodeHandler {
                        if httpStatusCodeHandler(httpResponse.statusCode) {
                            return
                        }
                    }
                    else if httpResponse.statusCode == 401 {
                        Auth.userLogout()
                        
                        return
                    }
                }
                
                if let error: Error = error {
                    onFailure(error)
                }
                else if let data: Data = data {
                    do {
                        let result: T = try JSONDecoder().decode(T.self, from: data)
                        
                        onSuccess(result)
                    }
                    catch {
                        onFailure(error)
                    }
                }
            }
        }
        
        dataTask.resume()
        
        return dataTask
    }
}

