//
//  BNBsLayout.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BNBsLayout: NSObject { }

extension BNBsLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
