//
//  ImageUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class RoomImageUseCase {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("imageDidDownload")
    }
    private let imageCache = ImageCache()
    private let networkDownloader: NetworkDownloader
    private let urlsQueue = DispatchQueue(label: "urls.serial.queue")
    private let semaphore = DispatchSemaphore(value: 10)
    
    init(networkDownloader: NetworkDownloader) {
        self.networkDownloader = networkDownloader
    }
    
    func download(roomID: Int, imageURL: URL, completionHandler: @escaping (Int?) -> ()) {
        urlsQueue.async { [weak self] in
            self?.semaphore.wait()
            self?.downloadImage(
                roomID: roomID,
                imageURL: imageURL,
                completionHandler: completionHandler
            )
        }
    }
    
    private func downloadImage(
        roomID: Int,
        imageURL: URL,
        completionHandler: @escaping (Int?) -> ()
    ) {
        networkDownloader.download(
            url: imageURL,
            completionHandler: { [weak self] tempURL, urlResponse in
                defer { self?.semaphore.signal() }
                
                guard let tempURL = tempURL else { return }
                guard let destinaionURL = self?.imageCache.downloadDestination(
                    url: imageURL
                    ) else { return }
                
                try? FileManager.default.moveItem(at: tempURL, to: destinaionURL)
                completionHandler(roomID)
            },
            failureHandler: { urlResponse, error in
                guard let error = error else { return }
                
                print(error.localizedDescription)
                completionHandler(nil)
        })
    }
}
