//
//  CGPieRing.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGPieRing: CGPieType {
    
    public var circle: CGCircle
    public var thickness: CGFloat
    public var direction: CGAngle.ClockDirection
    public var values: [CGFloat]
    public var paddingFraction: CGFloat
    
    public init(
        circle: CGCircle,
        thickness: CGFloat,
        direction: CGAngle.ClockDirection = .counterClockwise,
        paddingFraction: CGFloat = defaultPaddingFraction,
        values: CGFloat...)
    {
        self.init(circle: circle, thickness: thickness, direction: direction, paddingFraction: paddingFraction, values: values)
    }
    
    public init(
        circle: CGCircle,
        thickness: CGFloat,
        direction: CGAngle.ClockDirection = .counterClockwise,
        paddingFraction: CGFloat = defaultPaddingFraction,
        values: [CGFloat])
    {
        self.circle = circle
        self.thickness = thickness
        self.direction = direction
        self.paddingFraction = paddingFraction
        self.values = values
    }
}

// MARK:- Conformances

extension CGPieRing: SVG {
    public func add(to context: SVGContext) {
        guard let arcs = self.arcs, arcs.count > 1 else {
            return CGRing(circle: circle, thickness: thickness).add(to: context)
        }
        arcs.forEach{ CGRingSector(arc: $0, thickness: thickness).add(to: context) }
    }
}

extension CGPieRing: Equatable {}
public func == (lhs: CGPieRing, rhs: CGPieRing) -> Bool {
    return lhs.thickness == rhs.thickness
        && lhs.direction == rhs.direction
        && lhs.paddingFraction == rhs.paddingFraction
        && lhs.circle == rhs.circle
        && lhs.values == rhs.values
}

extension CGPieRing: CustomStringConvertible {
    public var description: String {
        return "CGPieRing(circle: \(circle), thickness: \(thickness), direction: \(direction), paddingFraction: \(paddingFraction), values: \(values))"
    }
}

