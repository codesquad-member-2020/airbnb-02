//
//  ReviewCountLabel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class ReviewCountLabel: UILabel {
    func setText(to count: String) {
        text = "(\(count))"
    }
}
