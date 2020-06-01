//
//  BNBsUseCaseTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb
@testable import Alamofire

final class BNBsUseCaseTests: XCTestCase {
    var bnbsUseCase: BNBsUseCase!
    
    override func setUp() {
        super.setUp()
        bnbsUseCase = BNBsUseCase(bnbsTask: BNBsTask(networkDispatcher: AF))
    }
    
    override func tearDown() {
        bnbsUseCase = nil
        super.tearDown()
    }
    
    func testBNBsUseCase_fetch_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 처리됨")
        defer { wait(for: [expectation], timeout: 10.0) }
        
        let requestCount = 10
        var count = 0
        bnbsUseCase.updateNotify { bnbs in
            _ = try! XCTUnwrap(bnbs)
            count += 1
            if count == requestCount {
                expectation.fulfill()
            }
        }
        
        for _ in 0 ..< requestCount {
            bnbsUseCase.append(bnbRequest: SearchRequest())
        }
    }
}
