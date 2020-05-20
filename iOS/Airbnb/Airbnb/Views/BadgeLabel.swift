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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureText()
    }
    
    private func configureText() {
        text = BadgeViewModel.text
    }
}
