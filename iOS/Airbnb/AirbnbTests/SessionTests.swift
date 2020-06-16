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
    private var urlSessionConfiguration: URLSessionConfiguration!
    private var session: Session!
    
    override func setUp() {
        setUpURLSessionConfiguration()
        setUpSession(configuration: urlSessionConfiguration)
    }
    
    private func setUpURLSessionConfiguration() {
        urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLProtocolMock.self]
    }
    
    private func setUpSession(configuration: URLSessionConfiguration) {
        session = Session(configuration: urlSessionConfiguration)
    }
    
    override func tearDown() {
        urlSessionConfiguration = nil
        session = nil
    }
    
    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "네트워크 응답 받음")
        defer { wait(for: [expectation], timeout: 1) }
        
        try? session.execute(
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

final class URLSessionConfigurationMock: URLSessionConfiguration { }

final class URLProtocolMock: URLProtocol {
    static let testURLs = [
        RoomsRequest().urlRequest()!: bnbsTestData
    ]
    static let bnbsTestData = Data.readJSON(of: Bundle(for: URLProtocolMock.self), for: "RoomsTestData")!
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let data = URLProtocolMock.testURLs[request] {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
