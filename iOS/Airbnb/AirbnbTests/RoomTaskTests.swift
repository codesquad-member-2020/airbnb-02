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
    func testPerform_디코딩_성공() {
        let expectation = XCTestExpectation(description: "디코딩 성공")
        defer { wait(for: [expectation], timeout: 1) }
        
        RoomsTask(networkDispatcher: NetworkDispatcherValidStub()).perform(RoomsRequest()) {
            XCTAssertNotNil($0)
            expectation.fulfill()
        }
    }
    
    func testPerform_잘못된_데이터로_인한_디코딩_실패() {
        let expectation = XCTestExpectation(description: "디코딩 실패")
        defer { wait(for: [expectation], timeout: 1) }
        
        RoomsTask(networkDispatcher: NetworkDispatcherInvalidStub()).perform(RoomsRequest()) {
            XCTAssertNil($0)
            expectation.fulfill()
        }
    }
    
    func test_request_properties() {
        //given
        let spy = NetworkDispatcherSpy()
        
        //when
        RoomsTask(networkDispatcher: spy).perform(RoomsRequest()) {  _ in
            
        }
        
        //then
        XCTAssertEqual(spy.method, .get)
        XCTAssertEqual(spy.path, Endpoints.main)
    }
}

final class NetworkDispatcherSpy: NetworkDispatcher {
    var path: String?
    var method: HTTPMethod?
    
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?) -> (), failureHandler: @escaping (URLResponse?, Error?) -> ()) throws {
        path = request.path
        method = request.method
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
