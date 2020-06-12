//
//  SearchRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct RoomsRequest: Request {
    var path: String {
        return Endpoints.main
    }
}
