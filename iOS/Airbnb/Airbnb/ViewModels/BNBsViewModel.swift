//
//  BNBsViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BNBsViewModel: NSObject {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("bnbsDidUpdate")
    }
    
    typealias Key = [BNB]?
    
    private let imageCache = ImageCache()
    private var bnbs: Key = nil {
        didSet { NotificationCenter.default.post(name: Notification.update, object: self) }
    }
    
    init(with bnbs: Key = nil) {
        self.bnbs = bnbs
    }
    
    func update(bnbs: Key) {
        self.bnbs = bnbs
    }
}

extension BNBsViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bnbs?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BNBCell.identifier, for: indexPath) as? BNBCell,
        let bnb = bnbs?[indexPath.row] else { return UICollectionViewCell() }
        cell.configure(with: bnb)
        
        var count = 0
        bnb.images.forEach { urlString in
            guard let url = URL(string: urlString) else { return }
            imageCache.read(lastPathComponent: url.lastPathComponent) { image in
                cell.imagePagingView.insert(at: count, image: image)
            }
            count += 1
        }
        return cell
    }
}
