//
//  GuideLabel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GuideLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configureFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureText()
        configureFont()
    }
    
    private func configureText() {
        text = GuideLabelViewModel.Text.default
        textColor = GuideLabelViewModel.Color.defaultText
    }
    
    private func configureFont() {
        font = GuideLabelViewModel.Font.default
    }
}
