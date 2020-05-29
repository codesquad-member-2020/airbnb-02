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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BNBCell.identifier, for: indexPath) as? BNBCell else { return UICollectionViewCell() }
        return cell
    }
}
