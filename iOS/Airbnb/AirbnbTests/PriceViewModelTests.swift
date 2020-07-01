//
//  PriceViewModelTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/07/01.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class PriceViewModelTests: XCTestCase {
    private var priceViewModel: PriceViewModel!
    
    override func setUp() {
        priceViewModel = PriceViewModel(prices: [(1000,1),(10000,3)])
    }

    override func tearDown() {
        priceViewModel = nil
    }
    
    func testPriceRangeTextSuccess_default값인_경우() throws {
        let rangeText = try XCTUnwrap(priceViewModel.priceRangeText())
        
        XCTAssertEqual(rangeText, "1,000원부터 10,000원 이상")
    }
    
    func testPriceRangeTextSuccess_default값이_아닌_경우() throws {
        let rangeText = try XCTUnwrap(priceViewModel.priceRangeText(minimumPercent: 0.5, maximumPercent: 1))
        
        XCTAssertEqual(rangeText, "10,000원부터 10,000원 이상")
    }
    
    func testPriceAverageTextSuccess_default값인_경우() throws {
        let averageText = try XCTUnwrap(priceViewModel.priceAvarageText())
        
        XCTAssertEqual(averageText, "일박 평균 가격은 7,750원")
    }
    
    func testPriceAverageTextSuccess_default값이_아닌_경우() throws {
        let averageText = try XCTUnwrap(priceViewModel.priceAvarageText(minimumPercent: 0.5, maximumPercent: 1))
        
        XCTAssertEqual(averageText, "일박 평균 가격은 10,000원")
    }
}
