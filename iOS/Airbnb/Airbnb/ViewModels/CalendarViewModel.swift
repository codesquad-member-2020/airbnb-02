//
//  CalendarViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

struct CalendarDates {
    let start: Date
    let end: Date
    var selected = [DateComponents]()
    
    init(startDate: Date, endDate: Date) {
        start = startDate
        end = endDate
    }
    
    mutating func updateSelected(date: DateComponents) {
        if selected.count > 1 {
            selected.removeFirst()
        }
        selected.append(date)
    }
}

final class CalendarViewModel: NSObject {
    typealias Key = CalendarDates
    
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("calendarDidUpdate")
    }
    
    private var dates: Key {
        didSet { NotificationCenter.default.post(name: Notification.update, object: self) }
    }
    
    private var calendar = Calendar.current
    private var monthInfoCache = [Int: MonthInfo]()
    
    init(startDate: Date, endDate: Date) {
        dates = CalendarDates(startDate: startDate, endDate: endDate)
        super.init()
    }
    
    func numberOfMonths() -> Int {
        return Calendar.current.dateComponents(
            [.month],
            from: dates.start,
            to: dates.end).month! + 1
    }
    
    func monthInfo(withOffset offset: Int) -> MonthInfo {
        let date = calendar.date(byAdding: .month, value: offset, to: dates.start)!
        let rangeOfDaysInMonth = calendar.range(of: .day, in: .month, for: date)!
        var firstDayOfMonth = calendar.dateComponents([.calendar, .year, .month, .day], from: date)
        firstDayOfMonth.day = 1
        let weekdayOfFirstDay = calendar.dateComponents([.weekday], from: firstDayOfMonth.date!)
        return MonthInfo(
            dateWithOffset: date,
            rangeOfDays: rangeOfDaysInMonth,
            startingIndex: weekdayOfFirstDay.weekday! - 1)
    }
    
    private func cacheMonthInfo(of section: Int) {
        monthInfoCache[section] = monthInfo(withOffset: section)
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
        if monthInfoCache[indexPath.section] == nil { cacheMonthInfo(of: indexPath.section) }
        let monthInfo = monthInfoCache[indexPath.section]!
        let day = indexPath.item - monthInfo.startingIndex + 1
        if monthInfo.rangeOfDays.contains(day) { cell.dayLabel.text = "\(day)" }
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
        if monthInfoCache[indexPath.section] == nil { cacheMonthInfo(of: indexPath.section) }
        let date = monthInfoCache[indexPath.section]!.dateWithOffset
        view.headerLabel.text = Self.yearAndMonthFormatter.string(from: date)
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
    struct MonthInfo: Equatable {
        let dateWithOffset: Date
        let rangeOfDays: Range<Int>
        let startingIndex: Int
    }
}
