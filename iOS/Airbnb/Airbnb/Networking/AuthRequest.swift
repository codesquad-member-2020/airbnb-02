//
//  AuthRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/02.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct AuthRequest: Request {
    var path: String {
        Endpoints.authURL
    }
    
    var queryItems: [URLQueryItem]? {
        return [AuthKeys.clientID, AuthKeys.scope]
    }
}
