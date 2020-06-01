//
//  AFSessionTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb
@testable import Alamofire

final class AFSessionTests: XCTestCase {
    static let sessionMock: Session = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return Session(configuration: configuration)
    }()
    
    private var afSession: AFSession!
    
    override func setUp() {
        afSession = AFSession(with: AFSessionTests.sessionMock)
    }
    
    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "네트워크 통신 성공")
        defer { wait(for: [expectation], timeout: 1) }
        
        afSession.execute(request: SearchRequest()) { data, response, error in
            defer { expectation.fulfill() }
            let expectedData = Data.readJSON(of: Bundle(for: AFSessionTests.self), for: "BNBsTestData")!
            XCTAssertEqual(data, expectedData)
            XCTAssertNil(error)
            let httpResponse = response as! HTTPURLResponse
            XCTAssertEqual(httpResponse.statusCode, 200)
        }
    }
}