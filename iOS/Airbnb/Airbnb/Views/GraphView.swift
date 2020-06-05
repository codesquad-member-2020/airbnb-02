//
//  GraphView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/05.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GraphView: UIView {
    weak var rangeSlider: RangeSlider?
    
    var data: [CGFloat] = [0, 0] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        guard let path = path() else { return }
        
        rangeSlider?.trackTintColor.setFill()
        path.lineWidth = 1
        path.fill()
        
        guard let rangeSlider = rangeSlider else { return }
        guard let highlightPath = highlightPath(
            minimumPercent: rangeSlider.lowerValue,
            maximumPercent: rangeSlider.upperValue
            ) else { return }
        
        rangeSlider.trackHighlightTintColor.setFill()
        highlightPath.lineWidth = 1
        highlightPath.fill()
    }
    
    private func path() -> UIBezierPath? {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)
        
        guard let firstY = coordinateYFor(index: 0) else { return nil }
        var firstPoint = CGPoint(x: bounds.origin.x, y: firstY)
        path.move(to: firstPoint)
        
        if (data.count == 2) {
            guard let secondY = coordinateYFor(index: 1) else { return nil }
            path.addLine(to: CGPoint(x: step, y: secondY))
            return path
        }
        
        var oldControlPoint: CGPoint?
        
        guard 1 < data.count else { return nil }
        for index in 1 ..< data.count {
            guard let secondY = coordinateYFor(index: index) else { return nil }
            let secondPoint = CGPoint(x: step * CGFloat(index), y: secondY)
            var thirdPoint: CGPoint?
            if index < data.count - 1 {
                guard let thirdY = coordinateYFor(index: index + 1) else { return nil }
                thirdPoint = CGPoint(x: step * CGFloat(index + 1), y: thirdY)
            }
            
            let newControlPoint = controlPointForPoints(p1: firstPoint, p2: secondPoint, next: thirdPoint)
            
            path.addCurve(to: secondPoint, controlPoint1: oldControlPoint ?? firstPoint, controlPoint2: newControlPoint ?? secondPoint)
            
            firstPoint = secondPoint
            oldControlPoint = antipodalFor(point: newControlPoint, center: secondPoint)
        }
        return path;
    }
    
    private func firstIndex(minimumPercent: CGFloat) -> Int {
        guard Int(minimumPercent * CGFloat(data.count)) > 0 else { return 0 }
        return Int(minimumPercent * CGFloat(data.count))
    }
    
    private func lastIndex(maximumPercent: CGFloat) -> Int {
        guard Int(maximumPercent * CGFloat(data.count)) < data.count else { return data.count - 1 }
        return Int(maximumPercent * CGFloat(data.count))
    }
    
    private func highlightPath(minimumPercent: CGFloat = 0, maximumPercent: CGFloat = 1) -> UIBezierPath? {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)
        
        let firstIndex = self.firstIndex(minimumPercent: minimumPercent)
        guard let firstY = coordinateYFor(index: firstIndex) else { return nil }
        let firstX = (CGFloat(firstIndex) / CGFloat(data.count)) * bounds.width
        
        let firstGround = CGPoint(x: firstX, y: bounds.height)
        path.move(to: firstGround)
        var firstPoint = CGPoint(x: firstX, y: firstY)
        path.addLine(to: firstPoint)
        
        if (data.count == 2) {
            guard let secondY = coordinateYFor(index: 1) else { return nil }
            path.addLine(to: CGPoint(x: step, y: secondY))
            return path
        }

        var oldControlPoint: CGPoint?

        let lastIndex = self.lastIndex(maximumPercent: maximumPercent)
        for index in firstIndex ... lastIndex {
            guard let secondY = coordinateYFor(index: index) else { return nil }
            let secondPoint = CGPoint(x: step * CGFloat(index), y: secondY)
            var thirdPoint: CGPoint?
            if index < data.count - 1 {
                guard let thirdY = coordinateYFor(index: index + 1) else { return nil }
                thirdPoint = CGPoint(x: step * CGFloat(index + 1), y: thirdY)
            }

            let newControlPoint = controlPointForPoints(p1: firstPoint, p2: secondPoint, next: thirdPoint)

            path.addCurve(to: secondPoint, controlPoint1: oldControlPoint ?? firstPoint, controlPoint2: newControlPoint ?? secondPoint)
            if index == lastIndex {
                path.addLine(to: CGPoint(x: secondPoint.x, y: bounds.height))
            }
                
            firstPoint = secondPoint
            oldControlPoint = antipodalFor(point: newControlPoint, center: secondPoint)
        }
        
        return path;
    }
    
    private func coordinateYFor(index: Int) -> CGFloat? {
        guard index < data.count else { return nil }
        return bounds.height - bounds.height * data[index] / (data.max() ?? 0)
    }
    
    private func antipodalFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let p1 = point, let center = center else {
            return nil
        }
        let newX = 2 * center.x - p1.x
        let diffY = abs(p1.y - center.y)
        let newY = center.y + diffY * (p1.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
    
    private func midPointForPoints(p1: CGPoint, p2: CGPoint) -> CGPoint {
        return CGPoint(x: (p1.x + p2.x) / 2, y: (p1.y + p2.y) / 2);
    }
    
    private func controlPointForPoints(p1: CGPoint, p2: CGPoint, next p3: CGPoint?) -> CGPoint? {
        guard let p3 = p3 else {
            return nil
        }
        
        let leftMidPoint  = midPointForPoints(p1: p1, p2: p2)
        let rightMidPoint = midPointForPoints(p1: p2, p2: p3)
        
        var controlPoint = midPointForPoints(p1: leftMidPoint, p2: antipodalFor(point: rightMidPoint, center: p2)!)
        
        if p1.y.between(a: p2.y, b: controlPoint.y) {
            controlPoint.y = p1.y
        } else if p2.y.between(a: p1.y, b: controlPoint.y) {
            controlPoint.y = p2.y
        }
        
        
        let imaginContol = antipodalFor(point: controlPoint, center: p2)!
        if p2.y.between(a: p3.y, b: imaginContol.y) {
            controlPoint.y = p2.y
        }
        if p3.y.between(a: p2.y, b: imaginContol.y) {
            let diffY = abs(p2.y - p3.y)
            controlPoint.y = p2.y + diffY * (p3.y < p2.y ? 1 : -1)
        }
        controlPoint.x += (p2.x - p1.x) * 0.1
        
        return controlPoint
    }
}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}
