//
//  DispatcherTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb
@testable import Alamofire

final class DispatcherTests: XCTestCase {
    func testAlamofireSession_fetch_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 들어옴")
        defer { wait(for: [expectation], timeout: 10.0) }

        let request = SearchRequest()
        AF.execute(request: request) { data, urlResponse, error in
            defer { expectation.fulfill() }

            XCTAssertNil(error)
            XCTAssertNotNil(urlResponse)
            XCTAssertNotNil(data)
        }
    }
}
