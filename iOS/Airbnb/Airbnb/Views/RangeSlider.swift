//
//  PriceSlider.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class RangeSlider: UIControl {
    let trackTintColor = UIColor(white: 0.9, alpha: 1)
    let trackHighlightTintColor = UIColor(white: 0.5, alpha: 1)
    var lowerValue: CGFloat = 0 {
        didSet {
            updateLayerFrames()
        }
    }
    var upperValue: CGFloat = 1 {
        didSet {
            updateLayerFrames()
        }
    }
    private let trackLayer = RangeSliderTrackLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTrackLayer()
        updateLayerFrames()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTrackLayer()
        updateLayerFrames()
    }
    
    private func configureTrackLayer() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        trackLayer.setNeedsDisplay()
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    private func updateLayerFrames() {
      CATransaction.begin()
      CATransaction.setDisableActions(true)

      trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
      trackLayer.setNeedsDisplay()
      CATransaction.commit()
    }
}
