//
//  Request.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Request {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    
    func urlRequest() -> URLRequest?
}

extension Request {
    var method: HTTPMethod { return .get }
    var queryItems: [URLQueryItem]? { return nil }
    var body: Data? { return nil }
    var headers: [String: String]? { return nil }
    
    func urlRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: path) else { return nil }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        headers?.forEach { urlRequest.addValue($1, forHTTPHeaderField: $1) }
        return urlRequest
    }
}
