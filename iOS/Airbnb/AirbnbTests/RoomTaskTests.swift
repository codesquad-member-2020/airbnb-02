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
            guard let rooms = $0 else { return }
            XCTAssertEqual(rooms, [Room()])
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
    func execute(request: Request,
                 completionHandler: @escaping (Data?, URLResponse?) -> (),
                 failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) throws {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneRoomTestData")!
        completionHandler(data, HTTPURLResponse())
    }
}

final class NetworkDispatcherInvalidStub: NetworkDispatcher {
    func execute(
        request: Request,
        completionHandler: @escaping (Data?, URLResponse?) -> (),
        failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) throws {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneInvalidRoomTestData")!
        completionHandler(data, HTTPURLResponse())
    }
}

private extension Room {
    init() {
        self.init(
            id: 1,
            title: "한남더힐1차",
            type: "아파트",
            location: "용산구",
            coordinate: Coordinate(latitude: 127.007289, longitude: 37.5361039),
            images: [],
            price: 1500000,
            favorite: false,
            review: Review(rating: 4.37, count: 300),
            superhost: true
        )
    }
}
