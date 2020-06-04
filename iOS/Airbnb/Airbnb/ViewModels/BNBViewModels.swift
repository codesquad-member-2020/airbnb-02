//
//  BNBsViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BNBViewModels: NSObject {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("bnbsDidUpdate")
    }
    
    private var bnbViewModels: [BNBViewModel] {
        didSet { NotificationCenter.default.post(name: Notification.update, object: self) }
    }
    
    init(with bnbs: [BNB] = []) {
        self.bnbViewModels = bnbs.map { BNBViewModel(bnb: $0) }
    }
    
    func update(bnbs: [BNB]) {
        self.bnbViewModels = bnbs.map { BNBViewModel(bnb: $0) }
    }
    
    func repeatViewModels(handler: (BNBViewModel) -> ()) {
        bnbViewModels.forEach { handler($0) }
    }
}

extension BNBViewModels: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return bnbViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BNBCell.identifier,
            for: indexPath) as? BNBCell
            else { return UICollectionViewCell() }
        
        let bnb = bnbViewModels[indexPath.row].bnb
        cell.configure(with: bnb)
        
        var index = 0
        bnb.images.forEach { urlString in
            guard let url = URL(string: urlString) else { return }
            guard let image = ImageCache.read(lastPathComponent: url.lastPathComponent) else { return }
            
            cell.imagePagingView.insert(at: index, image: image)
            index += 1
        }
        return cell
    }
}
