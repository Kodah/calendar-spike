//
//  CGFloat.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public let π = CGFloat.pi

// MARK:- Conversions

public protocol CGFloatConvertible {
    var cg: CGFloat { get }
}

extension Int: CGFloatConvertible {
    public var cg: CGFloat { return CGFloat(self) }
}

extension Float: CGFloatConvertible {
    public var cg: CGFloat { return CGFloat(self) }
}

extension Double: CGFloatConvertible {
    public var cg: CGFloat { return CGFloat(self) }
}

extension CGFloat: CGFloatConvertible {
    public var cg: CGFloat { return self }
}

public extension CGFloat {
    public var d: Double { return Double(self) }
    public var t: TimeInterval { return TimeInterval(self) }
}

// MARK:- Radians ←→ degrees

public extension CGFloatConvertible {
    
    public var radToDeg: CGFloat { return cg.radToDeg }
    public var degToRad: CGFloat { return cg.degToRad }
}

public extension CGFloat {
    
    public var radToDeg: CGFloat { return self * .a180OverPi }
    public var degToRad: CGFloat { return self * .piOver180 }
}

// MARK:- Static Vars

public extension CGFloat {
    
    public static let zero: CGFloat = 0
    public static let unit: CGFloat = 1
    
    public static let piOver180 = π / 180
    public static let a180OverPi = 180 / π
}

// MARK:- round, floor, ceil, abs

public extension CGFloat {
    
    public func ceil(places: Int) -> CGFloat {
        let exp = CoreGraphics.pow(10, places.cg) // TODO: memoize `exp`
        return CoreGraphics.ceil(self * exp) / exp
    }
    
    public func round(places: Int) -> CGFloat {
        let exp = CoreGraphics.pow(10, places.cg)
        return CoreGraphics.round(self * exp) / exp
    }
    
    public func floor(places: Int) -> CGFloat {
        let exp = CoreGraphics.pow(10, places.cg)
        return CoreGraphics.floor(self * exp) / exp
    }
    
    public var abs: CGFloat { return Swift.abs(self) }
    public var ceil: CGFloat { return CoreGraphics.ceil(self) }
    public var round: CGFloat { return CoreGraphics.round(self) }
    public var floor: CGFloat { return CoreGraphics.floor(self) }
    
    public var sin: CGFloat { return CoreGraphics.sin(self) }
    public var cos: CGFloat { return CoreGraphics.cos(self) }
}

public extension CGFloat {
    public func pow(_ x: CGFloat) -> CGFloat { return CoreGraphics.pow(self, x) }
    public func log(_ x: CGFloat) -> CGFloat { return CoreGraphics.log(self) }
    public func log2(_ x: CGFloat) -> CGFloat { return CoreGraphics.log2(self) }
    public func log10(_ x: CGFloat) -> CGFloat { return CoreGraphics.log10(self) }
}

// MARK:- toString

public extension CGFloat {
    
    public func toString(places: Int? = nil) -> String {
        let o = places.map{ round(places: $0) } ?? self
        if o.isRound && o <= Int.max.cg {
            return String(describing: Int(o))
        } else {
            return String(describing: o)
        }
    }
}

// MARK:- Clamp

public extension CGFloat {
    
    // TODO: generalise
    
    public func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        return range.clamp(self)
    }
    
    public func clamped(to range: ClosedRange<Double>) -> CGFloat {
        return (range.lowerBound.cg...range.upperBound.cg).clamp(self)
    }
    
    public func clamped(to range: ClosedRange<Int>) -> CGFloat {
        return (range.lowerBound.cg...range.upperBound.cg).clamp(self)
    }
}

// MARK:- CGFloat Collection Operators

public extension Collection where Iterator.Element == CGFloat {
    
    public var normalized: [CGFloat]? { // FIXME: there are many notions of `normalized`
        guard !isEmpty else {
            return nil
        }
        let values = map(abs) // FIXME: ?
        let sum = values.sum()
        guard sum > 0 else {
            return nil
        }
        return values.map{ $0 / sum }
    }
}

