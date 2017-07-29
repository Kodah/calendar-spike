//
//  CGRingSector.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGRingSector {
    public var center: CGPoint
    public var radius1: CGFloat
    public var radius2: CGFloat
    public var startAngle: CGAngle
    public var endAngle: CGAngle
    
    public init(
        center: CGPoint = .zero,
        radius1: CGFloat = 0,
        radius2: CGFloat,
        startAngle: CGAngle = .zero,
        endAngle: CGAngle)
    {
        self.center = center
        self.radius1 = radius1
        self.radius2 = radius2
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}

public extension CGRingSector {
    
    public init(
        arc: CGArc,
        thickness: CGFloat)
    {
        self.init(
            center: arc.center,
            radius1: arc.radius,
            radius2: arc.radius - thickness,
            startAngle: arc.startAngle,
            endAngle: arc.endAngle
        )
    }
}

// MARK:- Conformances

extension CGRingSector: SVG {
    public func add(to context: SVGContext) {
        let innerStartPoint = center.offsetBy(angle: startAngle, distance: radius1)
        let outerEndPoint = center.offsetBy(angle: endAngle, distance: radius2)
        context
            .move(to: innerStartPoint)
            .arc(at: center, radius: radius1, startAngle: startAngle, endAngle: endAngle)
            .line(to: outerEndPoint)
            .arc(at: center, radius: radius2, startAngle: endAngle, endAngle: startAngle)
            .close()
    }
}

extension CGRingSector: Equatable {}
public func == (lhs: CGRingSector, rhs: CGRingSector) -> Bool {
    return lhs.radius1 == rhs.radius1
        && lhs.radius2 == rhs.radius2
        && lhs.startAngle == rhs.startAngle
        && lhs.endAngle == rhs.endAngle
        && lhs.center == rhs.center
}

extension CGRingSector: CustomStringConvertible {
    public var description: String {
        return "CGRingSector(center: \(center), radius1: \(radius1), radius2: \(radius2), startAngle: \(startAngle / π) π, endAngle: \(endAngle / π) π)"
    }
}

