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
    
    func testConvertingToDateComponents() {
        let viewModel = CalendarViewModel(
            startDate: DateStubs.startDate,
            endDate: DateStubs.endDateAfterOneYear)
        viewModel.cacheMonthInfo(of: 2)
        let dateComponents = viewModel.dateComponents(fromIndexPath: IndexPath(item: 9, section: 2))
        let expectedDateComponents = DateComponents(calendar: .current, year: 2020, month: 8, day: 4)
        XCTAssertEqual(dateComponents, expectedDateComponents)
    }
    
    func testUpdatingSelectedDates() {
        let exp = expectation(description: "Observer has been called")
        let viewModel = CalendarViewModel(
            startDate: DateStubs.startDate,
            endDate: DateStubs.endDateAfterOneYear)
        viewModel.cacheMonthInfo(of: 2)
        var token: NotificationToken? = CalendarViewModel.Notification.addObserver { _ in
            exp.fulfill()
        }
        let dummy = IndexPath(item: 9, section: 2)
        viewModel.update(selectedIndexPath: dummy)
        waitForExpectations(timeout: 1)
        token = nil
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
