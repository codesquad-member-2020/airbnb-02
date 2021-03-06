//
//  BNBViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class BNBViewModel {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("bnbDidUpdate")
    }
    
    typealias Key = BNB
    
    var bnb: Key
    private var imageToken: NotificationToken?
    
    init(bnb: BNB) {
        self.bnb = bnb
        configureObserver()
    }
    
    private func configureObserver() {
        imageToken = ImageUseCase.Notification.addObserver{ [weak self] notification in
            guard let imageURL = notification.userInfo?["imageURL"] as? URL,
                let bnbID = self?.bnb.id else { return }
            
            self?.bnb.images.forEach {
                guard imageURL == URL(string: $0) else { return }
                
                NotificationCenter.default.post(
                    name: Notification.update,
                    object: self,
                    userInfo: ["bnbID": bnbID]
                )
            }
        }
    }
}
