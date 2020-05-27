//
//  DataExtensions.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

extension Data {
    static func readJSON(forResource name: String) -> Data? {
        guard let url = Bundle.main.url(
            forResource: name,
            withExtension: "json"
            ) else { return nil }
        return try? Data(contentsOf: url)
    }
}
