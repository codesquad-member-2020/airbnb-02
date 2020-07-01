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
    
    override func draw(in ctx: CGContext) {
        drawTrack(ctx: ctx)
    }
    
    private func drawTrack(ctx: CGContext) {
        drawBaseTrack(ctx: ctx)
        drawHightlightedTrack(ctx: ctx)
    }
    
    private func drawBaseTrack(ctx: CGContext) {
        guard let rangeSlider = rangeSlider else { return }
        let path = UIBezierPath(rect: bounds)
        
        ctx.addPath(path.cgPath)
        ctx.setFillColor(rangeSlider.trackTintColor.cgColor)
        ctx.fillPath()
    }
    
    private func drawHightlightedTrack(ctx: CGContext) {
        guard let rangeSlider = rangeSlider else { return }
        
        let lowerValuePosition = rangeSlider.positionForValue(rangeSlider.lowerValue)
        let upperValuePosition = rangeSlider.positionForValue(rangeSlider.upperValue)
        let highlightedRect = CGRect(
            x: lowerValuePosition,
            y: 0.0, width: upperValuePosition - lowerValuePosition,
            height: bounds.height
        )
        
        ctx.setFillColor(UIColor(white: 0.7, alpha: 1.0).cgColor)
        ctx.fill(highlightedRect)
    }
}
