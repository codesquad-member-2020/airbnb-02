//
//  LoginButton.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class LoginButton: CornerRoundedButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTitle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTitle()
    }
    
    private func configureTitle() {
        setTitleColor(tintColor.withAlphaComponent(0.5), for: .highlighted)
    }
}
