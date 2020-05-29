//
//  CacheTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class CacheTests: XCTestCase {
    private var cache: Cache!
    
    override func setUp() {
        super.setUp()
        cache = Cache()
    }
    
    override func tearDown() {
        cache = nil
        super.tearDown()
    }
    
    func testRead() {
        let expectation = XCTestExpectation(description: "데이터 같음")
        defer { wait(for: [expectation], timeout: 10.0) }
        
        let imageURLInCacheDirectory = URL(
        string: "https://a2.muscache.com/im/pictures/3726439/e4e357b6_original.jpg?aki_policy=large"
        )!
        
        cache.read(lastPathComponent: imageURLInCacheDirectory.lastPathComponent) { data in
            let origin = try! Data(contentsOf: imageURLInCacheDirectory)
            XCTAssertEqual(origin, data)
            expectation.fulfill()
        }
    }
    
    func testRead_defaultData() {
        let imageURLNotExistInCacheDirectory = URL(string: "https://yt3.ggpht.com/a/AATXAJw3t0hbuUhCAbETJlsH-gvYHpbmHxl4QsQ2dA=s900-c-k-c0xffffffff-no-rj-mo"
            )!
        cache.read(lastPathComponent: imageURLNotExistInCacheDirectory.lastPathComponent) { data in
            let origin = Data.readPNG(forResource: "airbnb")!
            XCTAssertEqual(origin, data)
        }
    }
}
