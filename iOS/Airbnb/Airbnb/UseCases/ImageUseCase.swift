//
//  ImageUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

import Alamofire

final class ImageUseCase {
    private var imageURLs = [URL]() { didSet { downloadImage() } }
    private let networkDispatcher: NetworkDispatcher
    
    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func append(imageURL: URL) {
        imageURLs.append(imageURL)
    }
    
    private func downloadImage() {
        guard !imageURLs.isEmpty,
            let imageURL = imageURLs.first else { return }
        
        networkDispatcher.download(url: imageURL) { tempURL, urlResponse, error in
            guard let tempURL = tempURL else { return }
            guard let destinaionURL = Cache.suggestedDownloadDestination(
                lastPathComponent: imageURL.lastPathComponent
                ) else { return }
            
            try? FileManager.default.moveItem(at: tempURL, to: destinaionURL)
        }
    }
}
