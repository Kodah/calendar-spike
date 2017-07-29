//
//  CGAngle.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 14/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public extension CGAngle {
    
    public enum ClockDirection {
        
        case clockwise
        case counterClockwise
        
        public static let defaultValue: ClockDirection = .clockwise
        
        public var sign: CGFloat {
            switch self {
            case .clockwise: return CGGeometry.isFlipped ? 1 : -1
            case .counterClockwise: return CGGeometry.isFlipped ? -1 : 1
            }
        }
        
        public init(clockwise: Bool) {
            self = clockwise ? .clockwise : .counterClockwise
        }
    }
}

public extension CGFloatConvertible {
    
    public var radians: CGAngle { return .radians(cg) }
    public var degrees: CGAngle { return .degrees(cg) }
    public var rotations: CGAngle { return .rotations(cg) }
}

public enum CGAngle: Comparable {
    
    case degrees(CGFloat)
    case radians(CGFloat)
    case rotations(CGFloat)
    
    public var inRadians: CGFloat {
        switch self {
        case .degrees(let deg): return deg.degToRad
        case .radians(let rad): return rad
        case .rotations(let frac): return frac * 2 * π
        }
    }
    
    public var inDegrees: CGFloat {
        switch self {
        case .degrees(let deg): return deg
        case .radians(let rad): return rad.radToDeg
        case .rotations(let frac): return frac * 360
        }
    }
    
    public var inRotations: CGFloat {
        switch self {
        case .degrees(let deg): return deg / 360
        case .radians(let rad): return rad / (2 * π)
        case .rotations(let frac): return frac
        }
    }
}

// MARK:- Comparable

public extension CGAngle {
    
    public static let zero: CGAngle = .rotations(0)
    public static let unit: CGAngle = fullTurn
    public static let fullTurn: CGAngle = .rotations(1)
}

// MARK:- vars

public extension CGAngle {
    
    public var abs: CGAngle { return inRotations.abs.rotations }
    public var sin: CGFloat { return CoreGraphics.sin(inRadians) }
    public var cos: CGFloat { return CoreGraphics.cos(inRadians) }
}

// MARK:- Operators

public extension CGAngle {
    
    public func map(transform: (CGFloat) -> CGFloat) -> CGAngle {
        switch self {
        case .degrees(let value): return .degrees(transform(value))
        case .radians(let value): return .radians(transform(value))
        case .rotations(let value): return .rotations(transform(value))
        }
    }

    public static func == (lhs: CGAngle, rhs: CGAngle) -> Bool {
        return lhs.inRotations == rhs.inRotations
    }
    
    public static func < (lhs: CGAngle, rhs: CGAngle) -> Bool {
        return lhs.inRotations < rhs.inRotations
    }
    
    public static prefix func - (angle: CGAngle) -> CGAngle {
        return angle.map{ -$0 }
    }
    
    public static func + (lhs: CGAngle, rhs: CGAngle) -> CGAngle {
        return (lhs.inRotations + rhs.inRotations).rotations
    }
    
    public static func - (lhs: CGAngle, rhs: CGAngle) -> CGAngle {
        return (lhs.inRotations - rhs.inRotations).rotations
    }
    
    // NOTE: Never implement + and - where rhs is CGFloatConvertible
    
    public static func * (lhs: CGAngle, rhs: CGFloatConvertible) -> CGAngle {
        return lhs.map{ $0 * rhs.cg }
    }
    
    public static func / (lhs: CGAngle, rhs: CGFloatConvertible) -> CGAngle {
        return lhs.map{ $0 / rhs.cg }
    }
}

// MARK:- Conformances

extension CGAngle: CustomStringConvertible {
    
    public var description: String {
        return "\(inDegrees.toString(places: 1))°"
    }
}
