//
//  ImageCache.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class ImageCache {
    func read(
        for directory: FileManager.SearchPathDirectory = .cachesDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask,
        lastPathComponent: String,
        completionHandler: (UIImage) -> ()
    ) {
        guard let destinationURL = suggestedDownloadDestination(
        for: directory,
        in: domain,
        lastPathComponent: lastPathComponent) else { return }
        
        if let data = try? Data(contentsOf: destinationURL) {
            completionHandler(UIImage(data: data)!)
        } else {
            guard let defaultData = UIImage(named: "airbnb") else { return }
            completionHandler(defaultData)
        }
    }
    
    func suggestedDownloadDestination(
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
    
    func fileExists(
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