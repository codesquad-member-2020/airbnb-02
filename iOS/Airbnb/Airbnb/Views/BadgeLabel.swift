//
//  BadgeLabel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/20.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class BadgeLabel: UILabel {
    @IBInspectable var horizontalInset: CGFloat = 6
    @IBInspectable var verticalInset: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configureFont()
        configureBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureText()
        configureFont()
        configureBorder()
    }
    
    private func configureText() {
        text = "SUPERHOST"
        textColor = .black
    }
    
    private func configureFont() {
        font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
    private func configureBorder() {
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }

    override var intrinsicContentSize: CGSize {
        let `super` = super.intrinsicContentSize
        return CGSize(
            width: `super`.width + horizontalInset * 2,
            height: `super`.height + verticalInset * 2
        )
    }
    
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(
            horizontalInset: horizontalInset,
            verticalInset: verticalInset
        )
        super.drawText(in: rect.inset(by: inset))
    }
}
