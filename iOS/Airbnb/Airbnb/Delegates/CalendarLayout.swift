//
//  CalendarLayout.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class CalendarLayout: NSObject {
    private var sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    private var cellSize: CGSize?
    private var startOffset: CGFloat?
}

extension CalendarLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = collectionView.frame.width / 7
        cellSize = CGSize(width: size, height: size)
        return cellSize!
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInset
    }
}

extension CalendarLayout: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.y
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        guard let view = scrollView as? UICollectionView,
            let layout = view.collectionViewLayout as? UICollectionViewFlowLayout,
            let cellHeight = cellSize?.height,
            let startOffset = startOffset else { return }
        
        let totalHeight = layout.headerReferenceSize.height + cellHeight * 6 + sectionInset.bottom
        
        if scrollView.contentOffset.y > targetContentOffset.pointee.y {
            targetContentOffset.pointee.y = startOffset - totalHeight
        } else {
            targetContentOffset.pointee.y = startOffset + totalHeight
        }
    }
}
