//
//  BNBTests.swift
//  AirbnbTests
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import XCTest
@testable import Airbnb

final class DecodableTests: XCTestCase {
    func testBNB_success() {
        let data = try! XCTUnwrap(Data.readJSON(forResource: "BNBsSuccessData"))
        let bnbs = try? JSONDecoder().decode([BNB].self, from: data)
        XCTAssertNotNil(bnbs)
    }
}
