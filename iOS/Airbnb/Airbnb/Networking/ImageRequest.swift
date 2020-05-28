//
//  ImageRequest.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct ImageRequest: Request {
    var path: String
    
    init(path: String) {
        self.path = path
    }
}
