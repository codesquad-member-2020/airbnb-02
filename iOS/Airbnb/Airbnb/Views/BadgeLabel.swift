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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureText()
        configureFont()
    }
    
    private func configureText() {
        text = BadgeViewModel.text
    }
    
    private func configureFont() {
        font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}
