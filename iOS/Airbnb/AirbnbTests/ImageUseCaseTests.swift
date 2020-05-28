//
//  ImageUseCaseTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb
@testable import Alamofire

final class ImageUseCaseTests: XCTestCase {
    var imageUseCase: ImageUseCase!
    
    override func setUp() {
        super.setUp()
        imageUseCase = ImageUseCase(networkDispatcher: AF)
    }
    
    override func tearDown() {
        imageUseCase = nil
        super.tearDown()
    }
    
    func testDownload_success() {
        let expectation = XCTestExpectation(description: "이미지 잘 다운됨")
        defer { wait(for: [expectation], timeout: 10.0) }
        
        //when
        let imageRequest = ImageRequest(path:
            "https://a2.muscache.com/im/pictures/9d2459d5-ca82-4ccf-b025-193d49e6fc9e.jpg?aki_policy=large")
        imageUseCase.append(imageRequest: imageRequest)
        DispatchQueue(label: "").asyncAfter(deadline: .now() + 5) {
            let lastPathComponent = URL(string: imageRequest.path)!.lastPathComponent
            guard let destinaionURL = try? FileManager.default.url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor:
                nil,
                create: false).appendingPathComponent(lastPathComponent) else { return }
            print(destinaionURL)
            let imageData = try? Data(contentsOf: destinaionURL)
            XCTAssertNotNil(imageData)
            expectation.fulfill()
        }
    }
}
