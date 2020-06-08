//
//  CalendarDates.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/08.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct CalendarDates {
    let start: Date
    let end: Date
    var selected = [DateComponents]()
    
    init(startDate: Date, endDate: Date) {
        start = startDate
        end = endDate
    }
    
    mutating func updateSelectedDate(_ newDate: DateComponents) {
        if selected.count > 1 {
            selected.removeFirst()
        }
        selected.append(newDate)
    }
    
    func isDayStartSelected(_ day: DateComponents) -> Bool {
        return selected.first == day
    }
    
    func isDayEndSelected(_ day: DateComponents) -> Bool {
        return selected.last == day
    }
    
    func isDayStaying(_ day: DateComponents) -> Bool {
        if selected.count != 2 { return false }
        guard let startDate = selected.first?.date,
            let endDate = selected.last?.date,
            let currentDate = day.date else { return false }
        if startDate.range(to: endDate).contains(currentDate) { return true }
        return false
    }
}
