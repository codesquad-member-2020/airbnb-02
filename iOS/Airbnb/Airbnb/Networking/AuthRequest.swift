//
//  AuthRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/02.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct AuthRequest: Request {
    var path: String
    var queryItems: [URLQueryItem]?
    
    init(path: String, queryItems: [URLQueryItem]) {
        self.path = path
        self.queryItems = queryItems
    }
}
