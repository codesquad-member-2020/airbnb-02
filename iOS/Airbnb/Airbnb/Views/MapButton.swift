//
//  MapButton.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/24.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class MapButton: RoundButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow(offset: CGSize(width: 0, height: 0), opacity: 0.5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow(offset: CGSize(width: 0, height: 0), opacity: 0.5)
    }
}

extension MapButton: Shadow { }
