//
//  SearchRequestTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

private struct FakeRequest: Request {
    var path: String { return "https://test/request" }
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "checkin", value: "2020-05-21"),
                URLQueryItem(name: "checkout", value: "2020-05-22"),
                URLQueryItem(name: "adults", value: "2"),
                URLQueryItem(name: "baby", value: "1")]
    }
}

final class RoomRequestTests: XCTestCase {
    func testRoomRequest_isCorrect() {
        let request = RoomsRequest()
        XCTAssertEqual(request.path, Endpoints.main)
        XCTAssertEqual(request.method, HTTPMethod.get)
    }
    
    func testFakeRequest_withQuery() {
        let request = FakeRequest()
        let urlRequest = request.urlRequest()!
        let url = try! XCTUnwrap(urlRequest.url)
        XCTAssertEqual(
            url.absoluteString,
            "https://test/request?checkin=2020-05-21&checkout=2020-05-22&adults=2&baby=1"
        )
    }
}
