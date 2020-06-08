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
    var stay = StayDates()
    
    init(startDate: Date, endDate: Date) {
        start = startDate
        end = endDate
    }
    
    mutating func updateSelectedDate(_ newDateComponents: DateComponents) {
        guard let newDate = newDateComponents.date else { return }
        stay.update(to: newDate)
    }
    
    func isDaySelected(_ day: DateComponents) -> Bool {
        guard let date = day.date else { return false }
        return stay.oneDate == date
    }
    
    func isDayStartSelected(_ day: DateComponents) -> Bool {
        guard let date = day.date else { return false }
        return stay.checkIn == date
    }
    
    func isDayEndSelected(_ day: DateComponents) -> Bool {
        guard let date = day.date else { return false }
        return stay.checkOut == date
    }
    
    func isDayStaying(_ day: DateComponents) -> Bool {
        guard let date = day.date else { return false }
        return stay.contains(date)
    }
}
