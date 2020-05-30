//
//  ImageCache.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class ImageCache {
    static func read(
        for directory: FileManager.SearchPathDirectory = .cachesDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        lastPathComponent: String
    ) -> UIImage? {
        guard let destinationURL = suggestedDownloadDestination(
        for: directory,
        in: domain,
        lastPathComponent: lastPathComponent) else { return nil }
        
        if let data = try? Data(contentsOf: destinationURL) {
            return UIImage(data: data)!
        } else {
            guard let defaultImage = UIImage(named: "airbnb") else { return nil }
            return defaultImage
        }
    }
    
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
    
    static func fileExists(
        for directory: FileManager.SearchPathDirectory = .cachesDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        lastPathComponent: String
    ) -> Bool {
        guard let destinationURL = suggestedDownloadDestination(
            for: directory,
            in: domain,
            lastPathComponent: lastPathComponent) else { return false }
        return FileManager.default.fileExists(atPath: destinationURL.path)
    }
}
