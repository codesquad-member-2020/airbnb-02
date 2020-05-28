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
    func configureShadow(
        color: UIColor = .lightGray,
        offset: CGSize = CGSize(width: 0, height: 0),
        radius: CGFloat = 8,
        opacity: Float = 0.2
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
