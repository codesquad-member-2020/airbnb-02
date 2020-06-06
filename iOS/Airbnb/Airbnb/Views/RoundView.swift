//
//  RoundView.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/06.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class RoundView: UIView {
    @IBInspectable var isRound: Bool = false {
        didSet { configureRound() }
    }
    
    private func configureRound() {
        layer.cornerRadius = isRound ? frame.width / 2 : 0
    }
}
