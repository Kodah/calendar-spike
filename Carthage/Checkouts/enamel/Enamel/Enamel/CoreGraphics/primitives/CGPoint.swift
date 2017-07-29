//
//  CGPoint.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

// MARK:- Static Constants

public extension CGPoint {
    
    public static let unit = CGPoint(x: 1, y: 1)
}

// MARK:- Vars

public extension CGPoint {

    public var sign: CGPoint { return CGPoint(x: x.sign.unit, y: y.sign.unit) }
    public var round: CGPoint { return CGPoint(x: x.round, y: y.round) }
    public var floor: CGPoint { return CGPoint(x: x.floor, y: y.floor) }
    public var ceil:  CGPoint { return CGPoint(x: x.ceil,  y: y.ceil) }
    public var abs: CGPoint { return CGPoint(x: x.abs, y: y.abs) }
    public var direction: CGAngle { return atan2(y, x).radians }
    public var magnitude: CGFloat { return hypot(x, y) }
}

// MARK:- init

public extension CGPoint {
    
    public init(direction: CGAngle, magnitude: CGFloat) {
        x = cos(direction.inRadians) * magnitude
        y =	sin(direction.inRadians) * magnitude
    }
    
    public func with(x: CGFloat? = nil, y: CGFloat? = nil) -> CGPoint {
        return CGPoint(x: x ?? self.x, y: y ?? self.y)
    }
}

// MARK:- Angle & Distance

public extension CGPoint {
    
    public func angle(to point: CGPoint) -> CGAngle {
        return atan2(point.y - y, point.x - x).radians
    }
    
    public func distance(to point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }
}

// MARK:- Offset By...

public extension CGPoint {
    
    public func offsetBy(_ t: CGTuple2Convertible) -> CGPoint {
        return self + t
    }
    
    public func offsetBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGPoint {
        return CGPoint(x: x + dx, y: y + dy)
    }
    
    public func offsetBy(angle: CGAngle, distance: CGFloat) -> CGPoint {
        return self + CGPoint(direction: angle, magnitude: distance)
    }
}

// MARK:- Playground

public extension CGPoint {
    
    public var dot: CGCircle { return CGCircle(center: self, radius: 1.5) }
}

// MARK:- Conformances

extension CGPoint: CGTuple2Convertible {
    public var tuple: CGTuple2 { return (x, y) }
    public init(_ tuple: CGTuple2) { x = tuple.0; y = tuple.1 }
}

extension CGPoint: CustomStringConvertible {
    public var description: String { return "CGPoint(x: \(x), y: \(y))" }
}
