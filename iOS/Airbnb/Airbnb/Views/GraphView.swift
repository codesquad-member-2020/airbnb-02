//
//  GraphView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/07/01.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GraphView: UIView {
    weak var rangeSlider: RangeSlider?
    var priceData = [CGFloat]()
    
    override func draw(_ rect: CGRect) {
    
    }
        
    private func curvedPath() -> UIBezierPath? {
        let path = UIBezierPath()
        let step = bounds.width / CGFloat(priceData.count - 1)
        let firstIndex = 0
        guard let firstY = coordinateYFor(index: firstIndex) else { return nil }
        
        var fitstPoint = CGPoint(x: 0, y: firstY)
        var oldControlPoint: CGPoint?
        path.move(to: fitstPoint)
        
        for index in firstIndex + 1 ..< priceData.count {
            guard let secondY = coordinateYFor(index: index) else { return nil }
            
            let secondPoint = CGPoint(x: step * CGFloat(index), y: secondY)
            var thirdPoint: CGPoint?
            
            if index < priceData.count - 1 {
                guard let thirdY = coordinateYFor(index: index + 1) else { return nil }
                
                thirdPoint = CGPoint(x: step * CGFloat(index + 1), y: thirdY)
            }
            
            let newControlPoint = controlPointFor(
                firstPoint: fitstPoint,
                secondPoint: secondPoint,
                next: thirdPoint
            )
            path.addCurve(
                to: secondPoint,
                controlPoint1: oldControlPoint ?? fitstPoint,
                controlPoint2: newControlPoint ?? secondPoint
            )
            oldControlPoint = oppositePointFor(point: newControlPoint, center: secondPoint)
            fitstPoint = secondPoint
        }
        
        path.addLine(to: CGPoint(x: bounds.width, y: bounds.height))
        path.addLine(to: CGPoint(x: 0.0, y: bounds.height))
        path.close()
        
        return path
    }
    
    private func coordinateYFor(index: Int) -> CGFloat? {
        guard index < priceData.count else { return nil }
        
        return bounds.height - bounds.height * CGFloat(priceData[index]) / CGFloat((priceData.max() ?? 0))
    }
    
    private func controlPointFor(
        firstPoint: CGPoint,
        secondPoint: CGPoint,
        next thirdPoint: CGPoint?
    ) -> CGPoint? {
        guard let point3 = thirdPoint else { return nil }
        
        let leftMidPoint  = midPointFor(firstPoint: firstPoint, secondPoint: secondPoint)
        let rightMidPoint = midPointFor(firstPoint: secondPoint, secondPoint: point3)
        var controlPoint = midPointFor(
            firstPoint: leftMidPoint,
            secondPoint: oppositePointFor(point: rightMidPoint, center: secondPoint)!
        )
        let oppositeOfControlPoint = oppositePointFor(point: controlPoint, center: secondPoint)!
        
        if firstPoint.y.between(a: secondPoint.y, b: controlPoint.y) {
            controlPoint.y = firstPoint.y
        } else if secondPoint.y.between(a: firstPoint.y, b: controlPoint.y) {
            controlPoint.y = secondPoint.y
        } else if secondPoint.y.between(a: point3.y, b: oppositeOfControlPoint.y) {
            controlPoint.y = secondPoint.y
        } else if point3.y.between(a: secondPoint.y, b: oppositeOfControlPoint.y) {
            let diffY = abs(secondPoint.y - point3.y)
            controlPoint.y = secondPoint.y + diffY * (point3.y < secondPoint.y ? 1 : -1)
        }
        
        controlPoint.x += (secondPoint.x - firstPoint.x) * 0.1
        return controlPoint
    }
    
    private func midPointFor(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        return CGPoint(
            x: (firstPoint.x + secondPoint.x) / 2,
            y: (firstPoint.y + secondPoint.y) / 2
        )
    }
    
    private func oppositePointFor(point: CGPoint?, center: CGPoint?) -> CGPoint? {
        guard let point = point, let center = center else { return nil }
        
        let newX = 2 * center.x - point.x
        let diffY = abs(point.y - center.y)
        let newY = center.y + diffY * (point.y < center.y ? 1 : -1)
        
        return CGPoint(x: newX, y: newY)
    }
    
    func append(data: CGFloat) {
        priceData.append(data)
    }
}

extension CGFloat {
    func between(a: CGFloat, b: CGFloat) -> Bool {
        return self >= Swift.min(a, b) && self <= Swift.max(a, b)
    }
}
