//
//  Cache.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct Cache {
    static func suggestedDownloadDestination(
        for directory: FileManager.SearchPathDirectory = .cachesDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        lastPathComponent: String
    ) -> URL? {
        guard let destinaionURL = try? FileManager.default.url(
            for: directory,
            in: domain,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent(lastPathComponent) else { return nil }
        return destinaionURL
    }
}
