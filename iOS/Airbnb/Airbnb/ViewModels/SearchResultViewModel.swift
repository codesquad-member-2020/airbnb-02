//
//  SearchResultViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class SearchResultViewModel: NSObject {
    typealias Key = [BNB]?
    
    private var bnbs: Key = nil {
        didSet { NotificationCenter.default.post(name: .bnbsDidUpdate, object: self) }
    }
    
    init(with bnbs: Key = nil) {
        self.bnbs = bnbs
    }
    
    func update(bnbs: Key) {
        self.bnbs = bnbs
    }
}

extension SearchResultViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BNBCell.identifier, for: indexPath) as? BNBCell else { return UICollectionViewCell() }
        return cell
    }
}

extension Notification.Name {
    static let bnbsDidUpdate = Notification.Name("bnbsDidUpdate")
}
