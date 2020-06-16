//
//  NetworkDispatcher.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

enum NetworkErrorCase: Error {
    case invalidURLString
    case notFound
}

protocol NetworkDispatcher {
    func execute(
        request: Request,
        completionHandler: @escaping (Data?, URLResponse?) -> (),
        failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) throws
}

