//
//  AuthKeys.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/01.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

enum AuthKeys {
    static let scheme = "squadbnb:"
    static let payloadKey = "token"
    
    static let clientID = URLQueryItem(name: "client_id", value: "8d92d01b11ba14d3d18f")
    static let scope = URLQueryItem(name: "scope", value: "user:email")
}
