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
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: DateComponents(year: 2), to: startDate)!
        let viewModel = CalendarViewModel(startDate: startDate, endDate: endDate)
        XCTAssertEqual(viewModel.numberOfMonths(), 25)
    }
}
