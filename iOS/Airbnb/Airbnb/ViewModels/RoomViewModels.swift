//
//  BNBsViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class RoomViewModels: NSObject {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("roomsDidUpdate")
    }
    private let imageCache = ImageCache()
    private var prices: (minimumPrice: Int, maximumPrice: Int)? = nil {
        didSet { NotificationCenter.default.post(name: Notification.update, object: self) }
    }
    
    private var roomViewModels: [RoomViewModel] {
        didSet { NotificationCenter.default.post(name: Notification.update, object: self) }
    }
    
    init(with rooms: [Room] = []) {
        self.roomViewModels = rooms.map { RoomViewModel(room: $0) }
    }
    
    private var filteredRoomViewModels: [RoomViewModel] {
        if prices == nil {
            return roomViewModels
        }
        return roomViewModelsByPrice()
    }
    
    private func roomViewModelsByPrice() -> [RoomViewModel] {
        guard let prices = prices else { return roomViewModels }
         
         return roomViewModels.filter {
             prices.minimumPrice <= $0.room.price &&
             prices.maximumPrice >= $0.room.price
         }
    }
    
    func update(rooms: [Room]) {
        self.roomViewModels = rooms.map { RoomViewModel(room: $0) }
    }
    
    func repeatViewModels(handler: (RoomViewModel) -> Void) {
        roomViewModels.forEach { handler($0) }
    }
    
    func configurePrices(minimumPrice: Int, maximumPrice: Int) {
        prices = (minimumPrice, maximumPrice)
    }
}

extension RoomViewModels: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return filteredRoomViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RoomCell.identifier,
            for: indexPath) as? RoomCell
            else { return UICollectionViewCell() }
        
        let room = filteredRoomViewModels[indexPath.row].room
        cell.configure(with: room)
        insertImages(cell, with: room)
        
        return cell
    }
    
    private func insertImages(_ cell: RoomCell, with room: Room) {
        room.repeatImages { imageURL, index in
            guard let image = imageCache.read(url: imageURL) else { return }
            
            cell.imagePagingView.insert(at: index, image: image)
        }
    }
}
