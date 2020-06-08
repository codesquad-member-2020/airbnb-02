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

struct StayDates {
    private var dates = [Date]()
    
    var checkIn: Date? {
        if dates.count == 2 {
            return formerOne(dates.first!, dates.last!)
        }
        return nil
    }
    
    var checkOut: Date? {
        if dates.count == 2 {
            return laterOne(dates.first!, dates.last!)
        }
        return nil
    }
    
    var oneDate: Date? {
        if dates.count == 1 {
            return dates.first
        }
        return nil
    }
    
    mutating func update(to date: Date) {
        if dates.count > 1 {
            dates.removeFirst()
        }
        dates.append(date)
    }
    
    func contains(_ date: Date) -> Bool {
        guard let checkIn = checkIn, let checkOut = checkOut else { return false }
        return (checkIn...checkOut).contains(date)
    }
    
    private func formerOne(_ firstDate: Date, _ lastDate: Date) -> Date {
        return firstDate < lastDate ? firstDate : lastDate
    }
    
    private func laterOne(_ firstDate: Date, _ lastDate: Date) -> Date {
        return firstDate > lastDate ? firstDate : lastDate
    }
}
