//
//  FilterButton.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
class FilterButton: UIButton {
    @IBInspectable var horizontalInset: CGFloat = 20 {
        didSet { configureInsets() }
    }
    
    @IBInspectable var verticalInset: CGFloat = 20 {
        didSet { configureInsets() }
    }
    
    @IBInspectable var color: UIColor = .lightGray {
        didSet { configureColor() }
    }

    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet { layer.borderWidth = borderWidth }
    }

    @IBInspectable var cornerRadius: CGFloat = 20 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    var action: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAction()
    }
    
    deinit {
        removeTarget(self, action: #selector(invokeAction), for: .touchUpInside)
    }
    
    private func configureInsets() {
        contentEdgeInsets = UIEdgeInsets(horizontalInset: horizontalInset, verticalInset: verticalInset)
    }
    
    private func configureColor() {
        layer.borderColor = color.cgColor
        setTitleColor(color, for: .normal)
    }
}

extension FilterButton {
    private func configureAction() {
        addTarget(self, action: #selector(invokeAction), for: .touchUpInside)
    }
    
    @objc func invokeAction(sender: FilterButton) { }
}

private extension UIEdgeInsets {
    init(horizontalInset: CGFloat, verticalInset: CGFloat) {
        self.init(top: verticalInset,
                  left: horizontalInset,
                  bottom: verticalInset,
                  right: horizontalInset)
    }
}
