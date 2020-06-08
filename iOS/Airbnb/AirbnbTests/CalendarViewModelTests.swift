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
    
    func testMonthInfo_With2MonthOffset() {
        let viewModel = CalendarViewModel(
            startDate: DateStubs.startDate,
            endDate: DateStubs.endDateAfterOneYear)
        let monthInfo = viewModel.monthInfo(withOffset: 2)
        
        var expectedDays = (1..<32).map { $0 }
        expectedDays.insert(contentsOf: [0, 0, 0, 0, 0, 0], at: 0)
        expectedDays.append(contentsOf: [0, 0, 0, 0, 0])
        let expectedMonthInfo = CalendarViewModel.MonthInfo(
            yearAndMonth: DateComponents(calendar: .current, year: 2020, month: 8),
            days: expectedDays)
        XCTAssertEqual(monthInfo, expectedMonthInfo)
    }
}

private struct DateStubs {
    static let calendar = Calendar.current
    static let oneYear = DateComponents(year: 1)
    static let twoYears = DateComponents(year: 2)
    
    static let startDate = DateComponents(calendar: .current, year: 2020, month: 6, day: 5).date!
    static let endDateAfterOneYear = calendar.date(byAdding: oneYear, to: startDate)!
    static let endDateAfterTwoYears = calendar.date(byAdding: twoYears, to: startDate)!
}
