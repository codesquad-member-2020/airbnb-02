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
        translatesAutoresizingMaskIntoConstraints = false
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
        text = BadgeViewModel.Text.default
        textColor = BadgeViewModel.Color.defaultText
    }
    
    private func configureFont() {
        font = BadgeViewModel.Font.default
    }
    
    private func configureBorder() {
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }
    
    private enum Padding {
        static let left: CGFloat = 6
        static let right: CGFloat = 6
        static let top: CGFloat = 2
        static let bottom: CGFloat = 2
    }
    
    override var intrinsicContentSize: CGSize {
        let `super` = super.intrinsicContentSize
        return CGSize(
            width: `super`.width + Padding.left + Padding.right,
            height: `super`.height + Padding.top + Padding.bottom
        )
    }
    
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(
            top: Padding.top,
            left: Padding.left,
            bottom: Padding.bottom,
            right: Padding.right)
        super.drawText(in: rect.inset(by: inset))
    }
}
