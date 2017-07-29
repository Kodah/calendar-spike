//
//  CGVector.swift
//  SwiftSky
//
//  Created by milos on 07/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

extension CGVector {
    public static let unit = CGVector(dx: 1, dy: 1)
}

// MARK:- Conformances

extension CGVector: CGTuple2Convertible {
    public var tuple: CGTuple2 { return (dx, dy) }
    public init(_ tuple: CGTuple2) { dx = tuple.0; dy = tuple.1 }
}

extension CGVector: CustomStringConvertible {
    public var description: String { return "CGVector(x: \(dx), y: \(dy))" }
}

