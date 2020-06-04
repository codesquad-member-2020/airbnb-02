//
//  CalendarViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class CalendarViewModel: NSObject {
    typealias Key = (startDate: Date, endDate: Date)
    
    private var period: Key
    
    init(startDate: Date, endDate: Date) {
        period = (startDate, endDate)
        super.init()
    }
    
    func numberOfMonths() -> Int {
        return Calendar.current.dateComponents(
            [.month],
            from: period.startDate,
            to: period.endDate).month! + 1
    }
}

extension CalendarViewModel: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfMonths()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 42
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarCell.identifier,
            for: indexPath
        ) as? CalendarCell else { return UICollectionViewCell() }
        return cell
    }
}
