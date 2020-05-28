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
    private var imageRequests = [ImageRequest]() { didSet { downloadImage() } }
    private let networkDispatcher: NetworkDispatcher
    
    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    func append(imageRequest: ImageRequest) {
        imageRequests.append(imageRequest)
    }
    
    private func downloadImage() {
        guard !imageRequests.isEmpty else { return }
        guard let imageRequest = imageRequests.first,
            let urlRequest = try? imageRequest.urlRequest() else { return }
        
        _ = networkDispatcher.download(urlRequest, interceptor: nil) { tempURL, response in
            if let destinaionURL = try? FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            ).appendingPathComponent(tempURL.lastPathComponent) {
                return (destinaionURL, .removePreviousFile)
            }
            return (tempURL, .removePreviousFile)
        }
    }
}
