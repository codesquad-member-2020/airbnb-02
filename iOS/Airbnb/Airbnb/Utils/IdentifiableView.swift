//
//  IdentifiableView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol IdentifiableView {
    static var identifier: String { get }
}

extension IdentifiableView {
    static var identifier: String {
        return String(describing: self)
    }
}