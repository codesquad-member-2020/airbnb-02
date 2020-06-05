//
//  GraphView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/05.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GraphView: UIView {
    var data: [CGFloat] = [0, 0, 0] {
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
        guard let path = quadCurvedPath() else { return }

        UIColor(white: 0.5, alpha: 1).setFill()
        path.lineWidth = 1
        path.fill()

        guard let backgroundPath = backgroundPath() else { return }
        
        UIColor(white: 0.5, alpha: 1).setFill()
        backgroundPath.lineWidth = 1
        backgroundPath.fill()
    }
    
    private func backgroundPath() -> UIBezierPath? {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.origin.x, y: bounds.height))
        
        guard let firstY = coordinateYFor(index: 0) else { return nil }
        let firstPoint = CGPoint(x: bounds.origin.x, y: firstY - 0.2)
        path.addLine(to: firstPoint)
        
        guard let lastY = coordinateYFor(index: data.count - 1) else { return nil }
        path.addLine(to: CGPoint(x: bounds.width, y: lastY - 0.2))
        
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        return path
    }
    
    private func quadCurvedPath() -> UIBezierPath? {
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
