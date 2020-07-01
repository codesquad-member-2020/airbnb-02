//
//  PriceSliderTrackLayer.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in cgContext: CGContext) {
        guard let slider = rangeSlider else {
          return
        }
        
        let path = UIBezierPath(roundedRect: slider.bounds, cornerRadius: cornerRadius)
        cgContext.addPath(path.cgPath)
        
        cgContext.setFillColor(slider.trackTintColor.cgColor)
        cgContext.fillPath()
        
        cgContext.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = slider.positionForValue(slider.lowerValue)
        let upperValuePosition = slider.positionForValue(slider.upperValue)
        let rect = CGRect(x: lowerValuePosition, y: 0,
                          width: upperValuePosition - lowerValuePosition,
                          height: bounds.height)
        cgContext.fill(rect)
    }
}
