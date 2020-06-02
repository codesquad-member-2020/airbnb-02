//
//  NetworkTask.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

protocol NetworkTask {
    associatedtype Input: Request
    associatedtype Output

    func perform(_ request: Input, completionHandler: @escaping (Output?) -> ())
}
