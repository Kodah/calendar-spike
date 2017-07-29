//
//  CoreGraphics.swift
//  Crack
//
//  Created by Rankovic, Milos (Developer) on 20/03/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

infix operator ± : NilCoalescingPrecedence

public func ± <T>(lhs: T, rhs: CGFloat) -> (T, within: CGFloat) {
    return (lhs, within: rhs)
}

public func ~= (lhs: Asserted<CGFloat>, rhs: (CGFloat, within: CGFloat)) {
    guard lhs.value.distance(to: rhs.0) <= rhs.within else {
        fail(lhs, rhs.0)
        return
    }
}

public func ~= (lhs: Asserted<CGAngle>, rhs: (CGAngle, within: CGFloat)) {
    let min = rhs.0.map{ $0 - rhs.within }
    let max = rhs.0.map{ $0 + rhs.within }
    guard lhs.value >= min && lhs.value <= max else {
        fail(lhs, rhs.0)
        return
    }
}

public func ~= <T: CGTuple2Convertible>(lhs: Asserted<T>, rhs: (T, within: CGFloat)) {
    let (l1, l2) = lhs.value.tuple
    let (r1, r2) = rhs.0.tuple
    guard
        l1.distance(to: r1) <= rhs.within,
        l2.distance(to: r2) <= rhs.within
        else
    {
        fail(lhs, rhs.0)
        return
    }
}

public func ~= (lhs: Asserted<CGRect>, rhs: (CGRect, within: CGFloat)) {
    let (l, r, e) = (lhs.value, rhs.0, rhs.within)
    guard
        l.x.distance(to: r.x) <= e,
        l.y.distance(to: r.y) <= e,
        l.width.distance(to: r.width) <= e,
        l.height.distance(to: r.height) <= e
        else
    {
        fail(lhs, rhs.0)
        return
    }
}
