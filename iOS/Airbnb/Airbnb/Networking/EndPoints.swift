//
//  EndPoints.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

enum Endpoints {
    static let baseURL = "http://13.125.56.23/api"
    static let main = "\(baseURL)/main"
    
    static let authURL = "https://github.com/login/oauth/authorize?client_id=\(AuthKeys.clientID)&scope=user:email"
}
