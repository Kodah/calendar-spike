//
//  CGArc.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGArc {
    
    public var center: CGPoint
    public var radius: CGFloat
    public var startAngle: CGAngle
    public var endAngle: CGAngle
    
    public init(
        center: CGPoint = .zero,
        radius: CGFloat,
        startAngle: CGAngle = .zero,
        endAngle: CGAngle)
    {
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    public init(
        circle: CGCircle,
        startAngle: CGAngle = .zero,
        endAngle: CGAngle)
    {
        self.init(
            center: circle.center,
            radius: circle.radius,
            startAngle: startAngle,
            endAngle: endAngle
        )
    }
}

// MARK:- Convenience init

public extension CGArc {
    
    public init(
        center: CGPoint = .zero,
        radius: CGFloat,
        startAngle: CGAngle = .zero,
        angle: CGAngle,
        direction: CGAngle.ClockDirection)
    {
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = startAngle + angle * direction.sign
    }
    
    public init(
        center: CGPoint = .zero,
        radius: CGFloat,
        startFraction: CGFloat = 0,
        fraction: CGFloat,
        direction: CGAngle.ClockDirection)
    {
        self.init(
            center: center,
            radius: radius,
            startAngle: startFraction.rotations,
            angle: fraction.rotations,
            direction: direction
        )
    }
    
    public init(
        circle: CGCircle,
        startFraction: CGFloat = 0,
        fraction: CGFloat,
        direction: CGAngle.ClockDirection)
    {
        self.init(
            center: circle.center,
            radius: circle.radius,
            startFraction: startFraction,
            fraction: fraction,
            direction: direction
        )
    }
}

// TODO: remove inits that take a `clockwise: Bool`

public extension CGArc {

    @available(*, deprecated, renamed: "CGArc.init(center:radius:startAngle:angle:direction:)")
    public init(
        center: CGPoint = .zero,
        radius: CGFloat,
        startAngle: CGAngle = .zero,
        angle: CGAngle,
        clockwise: Bool = false)
    {
        self.center = center
        self.radius = radius
        self.startAngle = startAngle
        self.endAngle = startAngle + angle * CGAngle.ClockDirection(clockwise: clockwise).sign
    }
    
    @available(*, deprecated, renamed: "CGArc.init(center:radius:startFraction:fraction:direction:)")
    public init(
        center: CGPoint = .zero,
        radius: CGFloat,
        startFraction: CGFloat = 0,
        fraction: CGFloat,
        clockwise: Bool = false)
    {
        self.init(
            center: center,
            radius: radius,
            startAngle: startFraction.rotations,
            angle: fraction.rotations,
            clockwise: clockwise
        )
    }
    
    @available(*, deprecated, renamed: "CGArc.init(circle:startFraction:fraction:direction:)")
    public init(
        circle: CGCircle,
        startFraction: CGFloat = 0,
        fraction: CGFloat,
        clockwise: Bool = false)
    {
        self.init(
            center: circle.center,
            radius: circle.radius,
            startFraction: startFraction,
            fraction: fraction,
            clockwise: clockwise
        )
    }
}

// MARK:- with...

public extension CGArc {
    
    public func with(
        center: CGPoint? = nil,
        radius: CGFloat? = nil,
        startAngle: CGAngle? = nil,
        endAngle: CGAngle? = nil)
        -> CGArc
    {
        return CGArc(
            center: center ?? self.center,
            radius: radius ?? self.radius,
            startAngle: startAngle ?? self.startAngle,
            endAngle: endAngle ?? self.endAngle
        )
    }
    
    public func with(circle: CGCircle) -> CGArc {
        return CGArc(circle: circle, startAngle: startAngle, endAngle: endAngle)
    }
}

// MARK:- Computed vars

public extension CGArc {

    public var circle: CGCircle {
        get { return CGCircle(center: center, radius: radius) }
        set { radius = newValue.radius; center = newValue.center }
    }
    
    public var clockwise: Bool {
        get {
            return CGGeometry.isClockwiseTurn(from: startAngle, to: endAngle)
        }
        set {
            if clockwise != newValue {
                swap(&startAngle, &endAngle)
            }
        }
    }
    
    public var angle: CGAngle {
        get { return (startAngle - endAngle).abs }
        set { endAngle = startAngle + newValue }
    }
    
    public var fraction: CGFloat {
        get { return angle.inRotations }
        set { endFraction = startFraction + newValue }
    }
    
    public var startFraction: CGFloat {
        get { return startAngle.inRotations }
        set { startAngle = newValue.rotations }
    }
    
    public var endFraction: CGFloat {
        get { return endAngle.inRotations }
        set { endAngle = newValue.rotations }
    }
}

// MARK:- Conformances

extension CGArc: SVG {
    public func add(to context: SVGContext) {
        let absAngle = self.angle.abs
        guard absAngle > .zero else {
            return
        }
        context
            .move(to: center.offsetBy(angle: startAngle, distance: radius))
            .arc(at: center, radius: radius, startAngle: startAngle, endAngle: endAngle)
    }
}

extension CGArc: Equatable {}
public func == (lhs: CGArc, rhs: CGArc) -> Bool {
    return lhs.radius == rhs.radius
        && lhs.startAngle == rhs.startAngle
        && lhs.endAngle == rhs.endAngle
        && lhs.center == rhs.center
}

extension CGArc: CustomStringConvertible {
    public var description: String {
        return "CGArc(center: \(center), radius: \(radius), startAngle: \(startAngle), endAngle: \(endAngle))"
    }
}
