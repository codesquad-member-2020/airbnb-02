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
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureShadow(offset: CGSize(width: 5, height: 5), opacity: 3)
    }
}

extension MapButton: Shadow { }
