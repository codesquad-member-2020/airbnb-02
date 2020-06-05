//
//  SearchRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct SearchRequest: Request {
    var path: String
    var queryItems: [URLQueryItem]?
    
    init(path: String = Endpoints.main, queryItems: [URLQueryItem]? = nil) {
        self.path = path
        self.queryItems = queryItems
    }
}
