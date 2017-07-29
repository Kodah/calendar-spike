//
//  CGPieType.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public protocol CGPieType {
    
    var circle: CGCircle { get }
    var direction: CGAngle.ClockDirection { get }
    
    /// - Note: Only modulus of each of `values` is used.
    var values: [CGFloat] { get }
    
    /// Spacing between arcs in radians
    var paddingFraction: CGFloat { get }
}

public extension CGPieType {
    
    public static var defaultPaddingFraction: CGFloat { return 0.02 }
    public static var minRepresentableFraction: CGFloat { return 0.002 }
    
    public var fractions: [CGFloat]? {
        return values.normalized
    }
    
    public var representedFractions: [CGFloat]? {
        guard let fractions = self.fractions else {
            return nil
        }
        let pad = representedPadding
        let representable = fractions.flatMap(representableFraction)
        let scale = representable.sum() - representable.count.cg * pad
        return representable.map{ $0 * scale }
    }
    
    public func representableFraction(fraction: CGFloat) -> CGFloat? {
        guard fraction > 0 else {
            return nil
        }
        guard fraction >= Self.minRepresentableFraction else {
            return Self.minRepresentableFraction
        }
        return fraction
    }
    
    public var representedPadding: CGFloat {
        return values.count > 1 ? paddingFraction : 0
    }
    
    public var arcs: [CGArc]? {
        guard let fractions = representedFractions else {
            return nil
        }
        let pad = representedPadding / 2 * direction.sign
        var sum: CGFloat = 0
        return fractions.map{ fraction in
            let arc = CGArc(
                circle: circle,
                startFraction: sum + pad,
                fraction: fraction,
                direction: direction
            )
            sum = arc.endFraction + pad
            return arc
        }
    }
}

