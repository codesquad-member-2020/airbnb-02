//
//  RoundButton.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var diameter: CGFloat = 50 {
        didSet { configureDiameter() }
    }
    
    private func configureDiameter() {
        widthAnchor.constraint(equalToConstant: diameter).isActive = true
        heightAnchor.constraint(equalToConstant: diameter).isActive = true
        layer.cornerRadius = diameter / 2
    }
}
