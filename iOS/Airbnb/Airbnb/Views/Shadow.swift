//
//  Shadow.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/24.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol Shadow where Self: UIView { }

extension Shadow {
    func configureShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
    }
}
