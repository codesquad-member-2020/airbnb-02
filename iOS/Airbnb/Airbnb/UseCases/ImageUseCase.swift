//
//  ImageUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class ImageUseCase {
    private let networkDispatcher: NetworkDispatcher
    private var imageURLs = [URL]() {
        didSet {
            guard oldValue.count < imageURLs.count else { return }
            downloadImage()
        }
    }
    
    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func append(imageURL: URL) {
        imageURLs.append(imageURL)
    }
    
    private func downloadImage() {
        guard let imageURL = imageURLs.dequeue() else { return }
            
        networkDispatcher.download(url: imageURL) { tempURL, urlResponse, error in
            guard let tempURL = tempURL else { return }
            guard let destinaionURL = ImageCache().suggestedDownloadDestination(
                lastPathComponent: imageURL.lastPathComponent
                ) else { return }
            
            try? FileManager.default.moveItem(at: tempURL, to: destinaionURL)
        }
    }
}
