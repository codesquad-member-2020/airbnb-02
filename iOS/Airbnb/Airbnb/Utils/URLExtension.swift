//
//  URLExtensions.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/16.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

extension URL {
    var underscorePath: String {
        return pathComponents.filter{ $0 != "/" }.reduce("") { "\($0)_\($1)" }
    }
}
