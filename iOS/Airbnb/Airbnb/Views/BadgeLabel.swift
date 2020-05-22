//
//  BadgeLabel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/20.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BadgeLabel: UILabel {
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
    
    private enum Padding {
        static let horizontalInset: CGFloat = 6
        static let verticalInset: CGFloat = 2
    }
    
    override var intrinsicContentSize: CGSize {
        let `super` = super.intrinsicContentSize
        return CGSize(
            width: `super`.width + Padding.horizontalInset * 2,
            height: `super`.height + Padding.verticalInset * 2
        )
    }
    
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(
            horizontalInset: Padding.horizontalInset,
            verticalInset: Padding.verticalInset
        )
        super.drawText(in: rect.inset(by: inset))
    }
}
