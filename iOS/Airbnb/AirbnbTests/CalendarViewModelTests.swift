//
//  CalendarViewModelTests.swift
//  AirbnbTests
//
//  Created by Chaewan Park on 2020/06/05.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

class CalendarViewModelTests: XCTestCase {
    func testNumberOfMonths_ForTwoYears() {
        let viewModel = CalendarViewModel(
            startDate: DateStubs.startDate,
            endDate: DateStubs.endDateAfterTwoYears)
        XCTAssertEqual(viewModel.numberOfMonths(), 25)
    }
    
    func testYearAndMonth_After3MonthOffset() {
        let viewModel = CalendarViewModel(
            startDate: DateStubs.startDate,
            endDate: DateStubs.endDateAfterOneYear)
        let date = viewModel.date(withMonthOffsetFromToday: 3)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let expectedDateComponents = DateComponents(year: 2020, month: 9, day: 5)
        XCTAssertEqual(dateComponents, expectedDateComponents)
    }
}

struct DateStubs {
    static let calendar = Calendar.current
    static let oneYear = DateComponents(year: 1)
    static let twoYears = DateComponents(year: 2)
    
    static let startDate = DateComponents(calendar: .current, year: 2020, month: 6, day: 5).date!
    static let endDateAfterOneYear = calendar.date(byAdding: oneYear, to: startDate)!
    static let endDateAfterTwoYears = calendar.date(byAdding: twoYears, to: startDate)!
}
