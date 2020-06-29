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
    let graphViewLayer = GraphViewLayer()
    
    var data = [CGFloat]()
    
    override func draw(_ rect: CGRect) {
        let path = curvedPath()
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        layer.addSublayer(graphViewLayer)
        graphViewLayer.rangeSlider = rangeSlider
        graphViewLayer.mask = mask
        graphViewLayer.frame = bounds
        graphViewLayer.setNeedsDisplay()
    }
        
    func curvedPath() -> UIBezierPath {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(data.count - 1)
        var point1 = CGPoint(x: 0, y: yCoordinate(index: 0))
        var oldControlPoint: CGPoint?
        
        path.move(to: point1)
        
        for index in 1 ..< data.count {
            let point2 = CGPoint(x: step * CGFloat(index), y: yCoordinate(index: index))
            var point3: CGPoint?
            
            if index < data.count - 1 {
                point3 = CGPoint(x: step * CGFloat(index + 1), y: yCoordinate(index: index + 1))
            }
            
            let newControlPoint = controlPoint(point1: point1, point2: point2, next: point3)
            path.addCurve(to: point2, controlPoint1: oldControlPoint ?? point1, controlPoint2: newControlPoint ?? point2)
            oldControlPoint = oppositePoint(point: newControlPoint, center: point2)
            point1 = point2
        }
        
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0.0, y: bounds.height))
        path.close()
        
        return path
    }
    
    func yCoordinate(index: Int) -> CGFloat {
        return bounds.height - bounds.height * CGFloat(data[index]) / CGFloat((data.max() ?? 0))
    }
    
    func controlPoint(point1: CGPoint, point2: CGPoint, next point3: CGPoint?) -> CGPoint? {
        guard let point3 = point3 else { return nil }
        
        let leftMidPoint  = midPoint(point1: point1, point2: point2)
        let rightMidPoint = midPoint(point1: point2, point2: point3)
        var controlPoint = midPoint(point1: leftMidPoint, point2: oppositePoint(point: rightMidPoint, center: point2)!)
        let oppositeOfControlPoint = oppositePoint(point: controlPoint, center: point2)!
        
        if point1.y.between(a: point2.y, b: controlPoint.y) {
            controlPoint.y = point1.y
        } else if point2.y.between(a: point1.y, b: controlPoint.y) {
            controlPoint.y = point2.y
        } else if point2.y.between(a: point3.y, b: oppositeOfControlPoint.y) {
            controlPoint.y = point2.y
        } else if point3.y.between(a: point2.y, b: oppositeOfControlPoint.y) {
            let diffY = abs(point2.y - point3.y)
            controlPoint.y = point2.y + diffY * (point3.y < point2.y ? 1 : -1)
        }
        
        controlPoint.x += (point2.x - point1.x) * 0.1
        
        return controlPoint
    }
    
    func midPoint(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    func oppositePoint(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let point = point, let center = center else { return nil }
        
        let newX = 2 * center.x - point.x
        let diffY = abs(point.y - center.y)
        let newY = center.y + diffY * (point.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}
