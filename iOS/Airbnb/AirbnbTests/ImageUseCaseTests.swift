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
        let imageURL = URL(
            string: "https://a2.muscache.com/im/pictures/3726439/e4e357b6_original.jpg?aki_policy=large"
            )!
        imageUseCase.append(imageURL: imageURL)
        DispatchQueue(label: "").asyncAfter(deadline: .now() + 5) {
            guard let destinaionURL = Cache().suggestedDownloadDestination(
                lastPathComponent: imageURL.lastPathComponent
                ) else { return }
            
            //then
            let imageData = try? Data(contentsOf: destinaionURL)
            XCTAssertNotNil(imageData)
            XCTAssertTrue(Cache().fileExists(lastPathComponent: imageURL.lastPathComponent))
            expectation.fulfill()
        }
    }
}
