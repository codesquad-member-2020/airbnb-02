//
//  UIEdgeInsetsExtension.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/22.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    init(horizontalInset: CGFloat, verticalInset: CGFloat) {
        self.init(top: verticalInset,
                  left: horizontalInset,
                  bottom: verticalInset,
                  right: horizontalInset)
    }
}
