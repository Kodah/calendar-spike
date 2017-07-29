//
//  SignedIntegerTyipe.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

extension Range: Bounded {}
extension ClosedRange: Bounded {}
extension CountableRange: Bounded {}
extension CountableClosedRange: Bounded {}

public protocol Bounded {
    associatedtype Bound: Comparable
    var lowerBound: Bound { get }
    var upperBound: Bound { get }
}

public extension Bounded {
    
    public func clamp(_ x: Bound) -> Bound {
        if x < lowerBound { return lowerBound }
        if x > upperBound { return upperBound }
        return x
    }
}
