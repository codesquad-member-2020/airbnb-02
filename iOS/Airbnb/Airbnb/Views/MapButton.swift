//
//  MapButton.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/24.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class MapButton: UIButton {
    @IBInspectable var diameter: CGFloat = 50 {
        didSet { configureDiameter() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
    }
    
    private func configureDiameter() {
        widthAnchor.constraint(equalToConstant: diameter).isActive = true
        heightAnchor.constraint(equalToConstant: diameter).isActive = true
        layer.cornerRadius = diameter / 2
    }
}

extension MapButton: Shadow { }
