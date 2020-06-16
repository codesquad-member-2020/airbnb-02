//
//  DataExtensions.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

enum DataError: Error {
    case notFound
}

extension Data {
    static func readJSON(of bundle: Bundle = .main, for name: String) -> Data? {
        guard let url = bundle.url(
            forResource: name,
            withExtension: "json"
            ) else { return nil }
        return try? Data(contentsOf: url)
    }
}
