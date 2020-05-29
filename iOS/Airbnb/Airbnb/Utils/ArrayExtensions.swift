//
//  ArrayExtensions.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

extension Array {
    mutating func pop() -> Element? {
        guard let element = first else { return nil }
        removeFirst()
        return element
    }
}
