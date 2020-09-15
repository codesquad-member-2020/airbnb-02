//
//  ImageCacheTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/07/24.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class ImageCacheTests: XCTestCase {
    private var imageCache: ImageCache!
    
    override func setUpWithError() throws {
        imageCache = ImageCache()
    }

    override func tearDownWithError() throws {
        imageCache = nil
    }
    
    func testRead_defautlImage_success() throws {
        // given
        let invalidURL = try XCTUnwrap(URL(string: "http://test"))
        
        // when
        let defualtImage = try XCTUnwrap(imageCache.read(url: invalidURL))
        
        // then
        XCTAssertEqual(defualtImage, UIImage(named: "airbnb")!)
    }
}
