//
//  URLProtocolMock.swift
//  AirbnbTests
//
//  Created by Chaewan Park on 2020/06/01.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation
@testable import Airbnb

class URLProtocolMock: URLProtocol {
    static var testURLs = [
        BNBsRequest().urlRequest()!: Data.readJSON(forResource: "BNBsTestData")!
    ]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let data = URLProtocolMock.testURLs[request] {
            let response = HTTPURLResponse(url: request.url!,
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
