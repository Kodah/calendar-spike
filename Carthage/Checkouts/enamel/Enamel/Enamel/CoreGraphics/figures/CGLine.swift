//
//  CGLine.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 06/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGLine {
    public var start: CGPoint
    public var end: CGPoint
    
    public init(start: CGPoint = .zero, end: CGPoint) {
        self.start = start
        self.end = end
    }
}

public extension CGLine {
    
    public static let zero = CGLine(start: .zero, end: .zero)
    public static let unit = CGLine(start: .zero, end: .unit)
}

public extension CGLine {
    
    public var length: CGFloat { return start.distance(to: end) }
}

// MARK:- Conformances

extension CGLine: SVG {
    public func add(to context: SVGContext) {
        context.move(to: start)
        if start != end {
            context.line(to: end)
        }
    }
}

extension CGLine: Equatable {}
public func == (lhs: CGLine, rhs: CGLine) -> Bool {
    return lhs.start == rhs.start
        && lhs.end == rhs.end
}

extension CGLine: CustomStringConvertible {
    public var description: String {
        return "CGLine(start: \(start), end: \(end))"
    }
}
