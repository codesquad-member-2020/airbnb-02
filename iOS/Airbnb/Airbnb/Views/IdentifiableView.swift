//
//  IdentifiableView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol IdentifierView where Self: UIView {
    static var identifier: String { get }
}

extension IdentifierView {
    static var identifier: String {
        return String(describing: self)
    }
}
