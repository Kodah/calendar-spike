//
//  CGPath.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 22/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public extension CGPath {
    
    public static var mutable: CGMutablePath { return CGMutablePath() }
}

// MARK:- SVGContext

extension CGMutablePath: SVGContext {
    
    public func close() -> Self {
        closeSubpath()
        return self
    }
    
    public func move(to point: CGPoint) -> Self {
        move(to: point) as Void // FIXME: conflicts with SVG
        return self
    }
    
    public func line(to point: CGPoint) -> Self {
        addLine(to: point)
        return self
    }
    
    public func arc(at center: CGPoint, radius: CGFloat, startAngle: CGAngle, endAngle: CGAngle) -> Self {
        addRelativeArc(center: center, radius: radius, startAngle: startAngle.inRadians, delta: (endAngle - startAngle).inRadians)
//        addArc(
//            center: center,
//            radius: radius,
//            startAngle: startAngle.inRadians,
//            endAngle: endAngle.inRadians,
//            clockwise: CGGeometry.isClockwiseTurn(from: startAngle, to: endAngle)
//        )
        return self
    }
    
    public func ellipse(at center: CGPoint, xRadius: CGFloat, yRadius: CGFloat) -> Self {
        let rect = CGRect(
            center: center,
            size: CGSize(width: xRadius * 2, height: yRadius * 2)
        )
        addEllipse(in: rect)
        return self
    }
    
    public func circle(at center: CGPoint, radius: CGFloat) -> Self {
        let rect = CGRect(
            center: center,
            size: CGSize(square: radius * 2)
        )
        addEllipse(in: rect)
        return self
    }
    
    public func rectangle(_ rect: CGRect) -> Self {
        addRect(rect)
        return self
    }
}
