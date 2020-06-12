//
//  SearchTaskTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class RoomTaskTests: XCTestCase {
    func testPerform_DecodingSeccess() {
        let expectation = XCTestExpectation(description: "디코딩 성공")
        defer { wait(for: [expectation], timeout: 1) }
        
        RoomsTask(networkDispatcher: NetworkDispatcherValidStub()).perform(RoomsRequest()) {
            guard let bnbs = $0 else { return }
            XCTAssertEqual(bnbs, [Room()])
            expectation.fulfill()
        }
    }
    
    func testPerform_DecodingFailure() {
        let expectation = XCTestExpectation(description: "디코딩 실패")
        defer { wait(for: [expectation], timeout: 1) }
        
        RoomsTask(networkDispatcher: NetworkDispatcherInvalidStub()).perform(RoomsRequest()) {
            XCTAssertNil($0)
            expectation.fulfill()
        }
    }
}

final class NetworkDispatcherValidStub: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneRoomTestData")!
        completionHandler(data, HTTPURLResponse(), nil)
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) { }
}

final class NetworkDispatcherInvalidStub: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneInvalidRoomTestData")!
        completionHandler(data, HTTPURLResponse(), nil)
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) { }
}

private extension Room {
    init() {
        self.init(
            id: 1,
            title: "해운대 펜트하우스 더탑플로어",
            type: "Entire apartment",
            location: "부산",
            images: [],
            price: 50000,
            favorite: false,
            review: Review(rating: 4.83, count: 200),
            superhost: true
        )
    }
}
