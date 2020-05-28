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
    let bnbsUseCase = BNBsUseCase(bnbsTask: BNBsTask(networkDispatcher: AF))
    
    func testBNBsUseCase_fetch_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 처리됨")
        defer { wait(for: [expectation], timeout: 10.0) }
        
        let requestCount = 10
        var count = 0
        bnbsUseCase.updateAfter { bnbs in
            _ = try! XCTUnwrap(bnbs)
            count += 1
            
            if count == requestCount {
                expectation.fulfill()
            }
        }
        
        for _ in 0 ..< requestCount {
            bnbsUseCase.append(bnbRequest: BNBRequest())
        }
    }
}
