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
    
    private var calendar: Key
    
    private var monthInfoCache = [Int: MonthInfo]()
    
    init(startDate: Date, endDate: Date) {
        calendar = (startDate, endDate)
        super.init()
    }
    
    func numberOfMonths() -> Int {
        return Calendar.current.dateComponents(
            [.month],
            from: calendar.startDate,
            to: calendar.endDate).month! + 1
    }
    
    func cacheMonthInfo(of section: Int) {
        let date = Calendar.current.date(byAdding: .month, value: section, to: calendar.startDate)!
        let rangeOfDaysInMonth = Calendar.current.range(of: .day, in: .month, for: date)!
        monthInfoCache[section] = MonthInfo(dateWitOffset: date, rangeOfDays: rangeOfDaysInMonth)
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard case UICollectionView.elementKindSectionHeader = kind,
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier:
                CalendarHeaderView.identifier,
                for: indexPath
            ) as? CalendarHeaderView else { return UICollectionReusableView() }
        cacheMonthInfo(of: indexPath.section)
        if let date = monthInfoCache[indexPath.section]?.dateWitOffset {
            view.headerLabel.text = Self.yearAndMonthFormatter.string(from: date)
        }
        return view
    }
}

extension CalendarViewModel {
    static let yearAndMonthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.calendar = Calendar.current
        return formatter
    }()
}

extension CalendarViewModel {
    struct MonthInfo {
        let dateWitOffset: Date
        let rangeOfDays: Range<Int>
//        let startingIndex: Int
    }
}
