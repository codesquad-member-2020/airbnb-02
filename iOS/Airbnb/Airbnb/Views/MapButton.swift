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
    
    var action: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
        configureAction()
    }
    
    deinit {
        removeTarget(self, action: #selector(invokeAction), for: .touchUpInside)
    }
    
    private func configureDiameter() {
        widthAnchor.constraint(equalToConstant: diameter).isActive = true
        heightAnchor.constraint(equalToConstant: diameter).isActive = true
    }
    
    private func configureAction() {
        addTarget(self, action: #selector(invokeAction), for: .touchUpInside)
    }
    
    @objc private func invokeAction(sender: MapButton) {
        action?()
    }
}

extension MapButton: Shadow { }
