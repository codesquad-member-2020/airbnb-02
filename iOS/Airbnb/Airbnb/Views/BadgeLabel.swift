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
    @IBInspectable var horizontalInset: CGFloat = 5
    @IBInspectable var verticalInset: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureBorder()
    }
    
    private func configureBorder() {
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(
            width: super.intrinsicContentSize.width + horizontalInset * 2,
            height: super.intrinsicContentSize.height + verticalInset * 2
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
