//
//  CGFloat+Darwin.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public extension CGFloat {
    
    public static var random: CGFloat { return CGFloat(UInt32.random) / CGFloat(UInt32.max) }
    public static var randomMaxRes: CGFloat { return CGFloat(UIntMax.random) / CGFloat(UIntMax.max) }
    
    /// "between" because it allows x > y
    public static func random(between x: CGFloat, and y: CGFloat) -> CGFloat {
        let (min, max) = x < y ? (x, y) : (y, x)
        return min + CGFloat.random * (max - min)
    }
    
    /// "between" because it allows x > y
    public static func random(between x : CGFloat, and y: CGFloat, power: CGFloat, pivot: CGFloat = 0.5) -> CGFloat {
        let (min, max) = x < y ? (x, y) : (y, x)
        let p = min + pivot * (max - min)
        let r = CGFloat.random.pow(power)
        if Bool.random {
            return p + r * (max - p)
        } else {
            return p - r * (p - min)
        }
    }
    
    // TODO:? `average` instead of `initial`
    // TODO: `randomWalk(count: Int, range: Range<CGFloat>)`
    public static func randomWalk(count: Int, initial: CGFloat, range: CGFloat) -> [CGFloat] {
        var xs: [CGFloat] = []
        xs.reserveCapacity(count)
        var x = initial
        let (from, to) = (-range / 2, range / 2)
        for _ in 1...count {
            x += CGFloat.random(between: from, and: to)
            xs.append(x)
        }
        return xs
    }
}

public extension CGAngle {
    
    public static var random: CGAngle {
        return .rotations(.random)
    }
}

public extension CGSize {
    
    public var randomPoint: CGPoint {
        return CGPoint(
            x: .random * width,
            y: .random * height
        )
    }
}

public extension CGRect {
    
    public var randomPoint: CGPoint {
        return size.randomPoint + origin
    }
}

public extension CGColor {
    
    public static var random: CGColor {
        return .with(rgb: (0...0xffffff).random)
    }
}
