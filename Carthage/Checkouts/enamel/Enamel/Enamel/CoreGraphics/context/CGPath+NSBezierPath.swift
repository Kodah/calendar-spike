//
//  CGPath2NSBezierPath.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 14/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import AppKit

public extension NSBezierPath {
    
    public convenience init(cgPath path: CGPath) {
        
        self.init()
        
        // FIXME: very suspicious memory management
        
        let pathPtr: UnsafeMutablePointer<NSBezierPath> = .allocate(capacity: 1)
        pathPtr.initialize(to: self)
        
        let infoPtr = UnsafeMutableRawPointer(pathPtr)
        
        path.apply(info: infoPtr) { (infoPtr, elementPtr) -> Void in
            guard let infoPtr = infoPtr else { return }
            let path = infoPtr.bindMemory(to: NSBezierPath.self, capacity: 1).pointee
            let element = elementPtr.pointee
            
            let pointsPtr = element.points
            
            switch element.type {
            case .moveToPoint:
                path.move(to: pointsPtr.pointee)
                
            case .addLineToPoint:
                path.line(to: pointsPtr.pointee)
                
            case .addQuadCurveToPoint:
                let firstPoint = pointsPtr.pointee
                let secondPoint = pointsPtr.successor().pointee
                
                let currentPoint = path.currentPoint
                let x = (currentPoint.x + 2 * firstPoint.x) / 3
                let y = (currentPoint.y + 2 * firstPoint.y) / 3
                let interpolatedPoint = CGPoint(x: x, y: y)
                
                let endPoint = secondPoint
                
                path.curve(to: endPoint, controlPoint1: interpolatedPoint, controlPoint2: interpolatedPoint)
                
            case .addCurveToPoint:
                let firstPoint = pointsPtr.pointee
                let secondPoint = pointsPtr.successor().pointee
                let thirdPoint = pointsPtr.successor().successor().pointee
                
                path.curve(to: thirdPoint, controlPoint1: firstPoint, controlPoint2: secondPoint)
                
            case .closeSubpath:
                path.close()
            }
            
            pointsPtr.deinitialize()
        }
    }
}
