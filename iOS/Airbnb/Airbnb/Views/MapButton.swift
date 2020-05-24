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
    @IBInspectable var cornerRadius: CGFloat = 25 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    @IBInspectable var diameter: CGFloat = 50 {
        didSet { configureDiameter() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow()
    }
    
    private func configureDiameter() {
        widthAnchor.constraint(equalToConstant: diameter).isActive = true
        heightAnchor.constraint(equalToConstant: diameter).isActive = true
    }
}

extension MapButton: Shadow {
    func configureShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 3
    }
}
