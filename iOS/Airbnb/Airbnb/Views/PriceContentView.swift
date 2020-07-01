//
//  PriceView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/30.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceContentView: UIView, Identifiable, NibLoadable {
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var priceAverage: UILabel!
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    @IBOutlet weak var graphView: GraphView!
}
