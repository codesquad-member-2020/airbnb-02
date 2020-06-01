//
//  SearchTaskTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class SearchTaskTests: XCTestCase {
    private var searchTask: SearchTask!
    
    func testTaskPerform_success() {
        let expectation = XCTestExpectation(description: "데이터 잘 처리됨")
        defer { wait(for: [expectation], timeout: 10.0) }
        let bnbRequest = SearchRequest()
        let bnbsTask = SearchTask(networkDispatcher: AFSession())
        bnbsTask.perform(bnbRequest) { bnbs in
            defer { expectation.fulfill() }
            _ = try! XCTUnwrap(bnbs)
        }
    }
}

final class NetworkDispatcherValidStub: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneBNBTestData")!
        completionHandler(data, HTTPURLResponse(), nil)
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) { }
}

final class NetworkDispatcherInvalidStub: NetworkDispatcher {
    func execute(request: Request, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let data = Data.readJSON(of: Bundle(for: type(of: self)), for: "OneInvalidBNBTestData")!
        completionHandler(data, HTTPURLResponse(), nil)
    }
    
    func download(url: URL, completionHandler: @escaping (URL?, URLResponse?, Error?) -> ()) { }
}
