//
//  GraphViewLayer.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/29.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GraphViewLayer: CALayer {
    weak var rangeSlider: RangeSlider?
    
    override func draw(in cgContext: CGContext) {
        drawTrack(cgContext: cgContext)
    }
    
    private func drawTrack(cgContext: CGContext) {
        drawBaseTrack(cgContext: cgContext)
        drawHightlightedTrack(cgContext: cgContext)
    }
    
    private func drawBaseTrack(cgContext: CGContext) {
        guard let rangeSlider = rangeSlider else { return }
        
        let path = UIBezierPath(rect: bounds)
        cgContext.addPath(path.cgPath)
        cgContext.setFillColor(rangeSlider.trackTintColor.cgColor)
        cgContext.fillPath()
    }
    
    private func drawHightlightedTrack(cgContext: CGContext) {
        guard let rangeSlider = rangeSlider else { return }
        
        let lowerValuePosition = rangeSlider.positionForValue(rangeSlider.lowerValue)
        let upperValuePosition = rangeSlider.positionForValue(rangeSlider.upperValue)
        let highlightedRect = CGRect(
            x: lowerValuePosition,
            y: 0.0, width: upperValuePosition - lowerValuePosition,
            height: bounds.height
        )
        
        cgContext.setFillColor(rangeSlider.trackHighlightTintColor.cgColor)
        cgContext.fill(highlightedRect)
    }
}
