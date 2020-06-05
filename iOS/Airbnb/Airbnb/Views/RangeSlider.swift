//
//  PriceSlider.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class RangeSlider: UIControl {
    enum Notification: Observable {
        static let update = Foundation.Notification.Name("valueDidUpdate")
    }
    
    let trackTintColor = UIColor(white: 0.9, alpha: 1)
    let trackHighlightTintColor = UIColor(white: 0.5, alpha: 1)
    let minimumValue: CGFloat = 0
    let maximumValue: CGFloat = 1
    var lowerValue: CGFloat = 0 {
        didSet {
            updateLayerFrames()
            NotificationCenter.default.post(
                name: Notification.update,
                object: self,
                userInfo: ["lowerValue": lowerValue, "upperValue": upperValue]
            )
        }
    }
    var upperValue: CGFloat = 1 {
        didSet {
            updateLayerFrames()
            NotificationCenter.default.post(
                name: Notification.update,
                object: self,
                userInfo: ["lowerValue": lowerValue, "upperValue": upperValue]
            )
        }
    }
    
    override var bounds: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    private let trackLayer = RangeSliderTrackLayer()
    private let lowerThumbImageView = UIImageView()
    private let upperThumbImageView = UIImageView()
    private let thumbImage = UIImage(systemName: "circle.fill")!
    private var previousLocation = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTrackLayer()
        configure(imageView: lowerThumbImageView)
        configure(imageView: upperThumbImageView)
        updateLayerFrames()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTrackLayer()
        configure(imageView: lowerThumbImageView)
        configure(imageView: upperThumbImageView)
        updateLayerFrames()
    }
    
    private func configureTrackLayer() {
        trackLayer.rangeSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        trackLayer.setNeedsDisplay()
    }
    
    private func configure(imageView: UIImageView) {
        imageView.image = thumbImage
        imageView.tintColor = trackHighlightTintColor
        addSubview(imageView)
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    func resetValues() {
        lowerValue = minimumValue
        upperValue = maximumValue
    }
    
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
    
    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowerThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowerValue),
                                           size: thumbImage.size)
        upperThumbImageView.frame = CGRect(origin: thumbOriginForValue(upperValue),
                                           size: thumbImage.size)
        
        CATransaction.commit()
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if lowerThumbImageView.frame.contains(previousLocation) {
            lowerThumbImageView.isHighlighted = true
        } else if upperThumbImageView.frame.contains(previousLocation) {
            upperThumbImageView.isHighlighted = true
        }
        
        return lowerThumbImageView.isHighlighted || upperThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / bounds.width
        previousLocation = location
        
        
        if lowerThumbImageView.isHighlighted {
            lowerValue += deltaValue
            let upperValue = upperThumbImageView.frame.minX / bounds.width
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue,
                                    upperValue: upperValue)
        } else if upperThumbImageView.isHighlighted {
            upperValue += deltaValue
            let lowerValue = lowerThumbImageView.frame.maxX / bounds.width
            upperValue = boundValue(upperValue, toLowerValue: lowerValue,
                                    upperValue: maximumValue)
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbImageView.isHighlighted = false
        upperThumbImageView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat, toLowerValue lowerValue: CGFloat, upperValue: CGFloat) -> CGFloat {
        return min(max(value, lowerValue), upperValue)
    }
}
