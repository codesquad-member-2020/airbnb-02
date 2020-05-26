//
//  CornerRoundedButton.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class CornerRoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 25 {
        didSet { layer.cornerRadius = cornerRadius }
    }
}
