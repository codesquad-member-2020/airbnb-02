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
        let expectation = XCTestExpectation(description: "네트워크 응답 받음")
        defer { wait(for: [expectation], timeout: 1) }
        
        afSession.execute(request: SearchRequest()) { data, response, error in
            defer { expectation.fulfill() }
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            let httpResponse = response as! HTTPURLResponse
            XCTAssertEqual(httpResponse.statusCode, 200)
        }
    }
}
