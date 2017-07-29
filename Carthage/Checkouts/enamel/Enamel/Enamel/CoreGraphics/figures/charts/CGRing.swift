//
//  CGRing.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGRing {
    
    public var center: CGPoint
    public var radius1: CGFloat
    public var radius2: CGFloat
    
    public init(center: CGPoint = .zero, radius1: CGFloat, radius2: CGFloat) {
        self.center = center
        self.radius1 = radius1
        self.radius2 = radius2
    }
    
    public init(
        circle: CGCircle,
        thickness: CGFloat)
    {
        self.init(
            center: circle.center,
            radius1: circle.radius,
            radius2: circle.radius - thickness
        )
    }
}

public extension CGRing {
    
    public var circle1: CGCircle {
        return CGCircle(center: center, radius: radius1)
    }
    
    public var circle2: CGCircle {
        return CGCircle(center: center, radius: radius2)
    }
}

// MARK:- Conformances

extension CGRing: SVG {
    public func add(to context: SVGContext) {
        circle1.add(to: context)
        circle2.add(to: context)
    }
}

extension CGRing: Equatable {}
public func == (lhs: CGRing, rhs: CGRing) -> Bool {
    return lhs.radius1 == rhs.radius1
        && lhs.radius2 == rhs.radius2
        && lhs.center == rhs.center
}

extension CGRing: CustomStringConvertible {
    public var description: String {
        return "CGRing(center: \(center), radius1: \(radius1), radius2: \(radius2))"
    }
}
