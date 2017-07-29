//
//  CGPie.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGPie: CGPieType {
    
    public var values: [CGFloat]
    public var circle: CGCircle
    public var direction: CGAngle.ClockDirection
    public var paddingFraction: CGFloat
    
    public init(
        circle: CGCircle,
        direction: CGAngle.ClockDirection = .counterClockwise,
        paddingFraction: CGFloat = defaultPaddingFraction,
        values: CGFloat...)
    {
        self.init(
            circle: circle,
            direction: direction,
            paddingFraction: paddingFraction,
            values: values
        )
    }
    
    public init(
        circle: CGCircle,
        direction: CGAngle.ClockDirection = .counterClockwise,
        paddingFraction: CGFloat = defaultPaddingFraction,
        values: [CGFloat])
    {
        self.circle = circle
        self.direction = direction
        self.paddingFraction = paddingFraction
        self.values = values
    }
}

// MARK:- Conformances

extension CGPie: SVG {
    
    public func add(to context: SVGContext) {
        guard let arcs = self.arcs, arcs.count > 1 else {
            return circle.add(to: context)
        }
        arcs.forEach{ addSector(forArc: $0, to: context) }
    }
    
    private func addSector(forArc arc: CGArc, to context: SVGContext) {
        let paddedCenter = arc.center.offsetBy(
            angle: (arc.startAngle + arc.endAngle) / 2,
            distance: paddingFraction * arc.radius * π
        )
        arc.add(to: context)
        context
            .line(to: paddedCenter)
            .close()
    }
}

extension CGPie: Equatable {}
public func == (lhs: CGPie, rhs: CGPie) -> Bool {
    return lhs.direction == rhs.direction
        && lhs.paddingFraction == rhs.paddingFraction
        && lhs.circle == rhs.circle
        && lhs.values == rhs.values
}

extension CGPie: CustomStringConvertible {
    public var description: String {
        return "CGPie(circle: \(circle), direction: \(direction), paddingFraction: \(paddingFraction), values: \(values))"
    }
}


