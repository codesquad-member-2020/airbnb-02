//
//  SearchBar.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/20.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class SearchBar: UITextField {
    @IBInspectable var layerColor: UIColor = .clear {
        didSet { configureLayer() }
    }
    
    private let convexLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayer()
    }
    
    private func configureLayer() {
        convexLayer.backgroundColor = layerColor.cgColor
        convexLayer.frame = CGRect(origin: bounds.origin, size: bounds.size)
        layer.addSublayer(convexLayer)
    }
}
