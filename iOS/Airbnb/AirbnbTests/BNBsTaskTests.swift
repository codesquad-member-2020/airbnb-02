//
//  BNBsTaskTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb
@testable import Alamofire

final class BNBsTaskTests: XCTestCase {
    func testTaskPerform_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 처리됨")
              defer { wait(for: [expectation], timeout: 10.0) }
        let bnbRequest = BNBRequest()
        let bnbsTask = BNBsTask(networkDispatcher: AF)
        bnbsTask.perform(bnbRequest) { bnbs in
            defer { expectation.fulfill() }
            _ = try! XCTUnwrap(bnbs)
        }
    }
}
