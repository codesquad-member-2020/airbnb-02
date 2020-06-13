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

final class SessionTests: XCTestCase {
    private let sessionMock: Session = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolMock.self]
        return Session(configuration: configuration)
    }()
    
    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "네트워크 응답 받음")
        defer { wait(for: [expectation], timeout: 1) }
        
        try? sessionMock.execute(
            request: RoomsRequest(),
            completionHandler: { data, response in
                defer { expectation.fulfill() }
                
                XCTAssertNotNil(data)
                let httpResponse = response as! HTTPURLResponse
                XCTAssertEqual(httpResponse.statusCode, 200)
        }, failureHandler: { response, error in
            
        })
    }
}
