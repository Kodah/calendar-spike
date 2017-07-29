//
//  CGEllipse.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 10/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGEllipse {
    
    public var center: CGPoint
    public var xRadius: CGFloat
    public var yRadius: CGFloat
    
    public init(center: CGPoint = .zero, xRadius: CGFloat, yRadius: CGFloat) {
        self.center = center
        self.xRadius = xRadius
        self.yRadius = yRadius
    }
}

// MARK:- .with...

public extension CGEllipse {
    
    public func with(center: CGPoint? = nil, xRadius: CGFloat? = nil, yRadius: CGFloat? = nil) -> CGEllipse {
        return CGEllipse(
            center: center ?? self.center,
            xRadius: xRadius ?? self.xRadius,
            yRadius: yRadius ?? self.yRadius
        )
    }
}

// MARK:- Static Constants

public extension CGEllipse {
    
    public static let zero = CGEllipse(center: .zero, xRadius: .zero, yRadius: .zero)
    public static let unit = CGEllipse(center: .zero, xRadius: .unit, yRadius: .unit)
}

// MARK:- Computed Properties

public extension CGEllipse {
    
    public var xDiameter: CGFloat { return xRadius * 2 }
    public var yDiameter: CGFloat { return yRadius * 2 }
    public var size: CGSize { return CGSize(width: xDiameter, height: yDiameter) }
}

// MARK:- Creators

public extension CGEllipse {
    
    public func scaled(by scale: CGFloat) -> CGEllipse {
        return CGEllipse(center: center, xRadius: xRadius * scale, yRadius: yRadius * scale)
    }
    
    public func resized(by dr: CGFloat) -> CGEllipse {
        return CGEllipse(center: center, xRadius: xRadius + dr, yRadius: yRadius + dr)
    }
}

// MARK:- Non-Mutating Methods

public extension CGEllipse {
    
    public func point(atAngle angle: CGFloat) -> CGPoint {
        return CGPoint(
            x: xRadius * cos(angle),
            y: yRadius * sin(angle)
        )
    }
    
    public func points(count: Int) -> [CGPoint] {
        guard count > 0 else { return [] }
        return (0..<count).map{ point(atAngle: ($0.cg / count.cg) * 2 * π) }
    }
}

// MARK:- Conformances

extension CGEllipse: SVG {
    public func add(to context: SVGContext) {
        context.ellipse(at: center, xRadius: xRadius, yRadius: yRadius)
    }
}
