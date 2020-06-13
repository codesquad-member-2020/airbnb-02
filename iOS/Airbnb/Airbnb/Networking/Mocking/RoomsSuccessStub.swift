//
//  MockRoomsDispatcher.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/12.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct RoomsSuccessStub: NetworkDispatcher {
    func execute(
        request: Request,
        completionHandler: @escaping (Data?, URLResponse?) -> (),
        failureHandler: @escaping (URLResponse?, Error?) -> ()
    ) throws {
        guard let jsonData = Data.readJSON(for: "RoomsData") else { return }
        completionHandler(jsonData, nil)
    }
}
