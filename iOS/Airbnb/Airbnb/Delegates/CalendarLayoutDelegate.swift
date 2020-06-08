//
//  CalendarLayoutDelegate.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class CalendarLayoutDelegate: NSObject {
    private let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    private let headerHeight: CGFloat = 60
    private var sectionHeight: CGFloat?
    private var startSectionIndex: Int?
    
    var didSelectItem: ((IndexPath) -> Void)?
}

extension CalendarLayoutDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem?(indexPath)
    }
}

extension CalendarLayoutDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let size = collectionView.frame.width / 7
        sectionHeight = sectionHeight(cellHeight: size)
        return CGSize(width: size, height: size)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInset
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
    
    private func sectionHeight(cellHeight: CGFloat) -> CGFloat {
        return headerHeight + cellHeight * 6 + sectionInset.top + sectionInset.bottom
    }
}

extension CalendarLayoutDelegate: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let sectionHeight = sectionHeight else { return }
        startSectionIndex = Int((scrollView.contentOffset.y + 10) / sectionHeight)
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        guard let startIndex = startSectionIndex, let sectionHeight = sectionHeight else { return }
        var targetSectionIndex = startIndex
        if velocity.y > 0 {
            targetSectionIndex += 1
        } else {
            targetSectionIndex -= 1
        }
        targetContentOffset.pointee.y = CGFloat(targetSectionIndex) * sectionHeight
        scrollView.decelerationRate = .fast
    }
}
