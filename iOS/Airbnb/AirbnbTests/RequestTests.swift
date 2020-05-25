//
//  RequestTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class RequestTests: XCTestCase {
    func testBNBRequest_path_success() {
        let request = BNBRequest()
        XCTAssertEqual(request.path, "http://13.125.56.23/api/main")
    }
    
    func testBNBRequest_fetch_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 들어옴")
        defer { wait(for: [expectation], timeout: 10.0) }
        
        let request = BNBRequest()
        let urlRequest = try? request.urlRequest()
        URLSession.shared.dataTask(with: try! XCTUnwrap(urlRequest))
        { data, urlResponse, error in
            defer { expectation.fulfill() }
            
            XCTAssertNil(error)
            XCTAssertNotNil(urlResponse)
            XCTAssertNotNil(data)
        }.resume()
    }
}
