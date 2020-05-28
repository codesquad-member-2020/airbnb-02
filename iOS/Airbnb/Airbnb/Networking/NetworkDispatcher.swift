//
//  NetworkDispatcher.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

import Alamofire

protocol NetworkDispatcher {
    func excute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ())
}

extension Session: NetworkDispatcher {
    func excute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let urlRequest = try? request.urlRequest() else { return }
        self.request(urlRequest).validate().response { afDataResponse in
            completionHandler(afDataResponse.data, afDataResponse.response, afDataResponse.error)
        }
    }
}
