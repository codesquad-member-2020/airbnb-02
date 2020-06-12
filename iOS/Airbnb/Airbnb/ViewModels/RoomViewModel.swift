//
//  BNBViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class RoomViewModel {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("roomDidUpdate")
    }
    
    typealias Key = Room
    
    var room: Key
    private var imageToken: NotificationToken?
    
    init(room: Room) {
        self.room = room
        configureObserver()
    }
    
    private func configureObserver() {
        imageToken = ImageUseCase.Notification.addObserver{ [weak self] notification in
            guard let imageURL = notification.userInfo?["imageURL"] as? URL,
                let roomID = self?.room.id else { return }
            
            self?.room.images.forEach {
                guard imageURL == URL(string: $0) else { return }
                
                NotificationCenter.default.post(
                    name: Notification.update,
                    object: self,
                    userInfo: ["roomID": roomID]
                )
            }
        }
    }
}
