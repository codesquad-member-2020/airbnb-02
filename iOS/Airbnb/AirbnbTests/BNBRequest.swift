//
//  BNBRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct BNBRequest: Request {
    var path: String {
        return "http://13.125.56.23/api/main"
    }
}
