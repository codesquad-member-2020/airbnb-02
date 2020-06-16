//
//  ImageCache.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

struct ImageCache {
    private let directory: FileManager.SearchPathDirectory
    private let domain: FileManager.SearchPathDomainMask
    
    init(directory: FileManager.SearchPathDirectory = .cachesDirectory,
         domain: FileManager.SearchPathDomainMask = .userDomainMask) {
        self.directory = directory
        self.domain = domain
    }
    
    func read(url: URL) -> UIImage? {
        guard let destinationURL = downloadDestination(url: url) else { return nil }
        
        if let data = try? Data(contentsOf: destinationURL) {
            return UIImage(data: data)!
        } else {
            guard let defaultImage = UIImage(named: "airbnb") else { return nil }
            return defaultImage
        }
    }
    
    func downloadDestination(url: URL) -> URL? {
        guard let destinaionURL = try? FileManager.default.url(
            for: directory,
            in: domain,
            appropriateFor: nil,
            create: false)
            .appendingPathComponent(url.underscorePath) else { return nil }
        return destinaionURL
    }
    
    func fileExists(url: URL) -> Bool {
        guard let destinationURL = downloadDestination(url: url) else { return false }
        return FileManager.default.fileExists(atPath: destinationURL.path)
    }
}
