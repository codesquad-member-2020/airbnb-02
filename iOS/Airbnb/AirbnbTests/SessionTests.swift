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
    func testExecute_success() {
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.protocolClasses = [URLProtocolSuccessStub.self]
        let session = Session(configuration: urlSessionConfiguration)
        
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
    
    func testExecute_failure_by_invalidURL() throws {
        do {
            try AF.execute(
                request: RequestInvalidURLStub(),
                completionHandler: { _, _ in },
                failureHandler: { _, _ in })
        } catch {
            let networkErrorCase = try XCTUnwrap(error as? NetworkErrorCase)
            XCTAssertEqual(networkErrorCase, NetworkErrorCase.invalidURLString)
        }
    }
}

final class URLProtocolSuccessStub: URLProtocol {
    static let testURLs = [
        RoomsRequest().urlRequest()!: bnbsTestSuccessData
    ]
    static let bnbsTestSuccessData = Data.readJSON(of: Bundle(for: URLProtocolSuccessStub.self), for: "RoomsTestData")!
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let data = URLProtocolSuccessStub.testURLs[request] {
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

final class RequestInvalidURLStub: Airbnb.Request {
    var path: String {
        return "부적합URL"
    }
}
