//
//  CGSector.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGSector {
    
    public var arc: CGArc
    
    public init(arc: CGArc) {
        self.arc = arc
    }
}

// MARK:- Conformances

extension CGSector: SVG {
    public func add(to context: SVGContext) {
        arc.add(to: context)
        context
            .line(to: arc.center)
            .close()
    }
}

extension CGSector: Equatable {}
public func == (lhs: CGSector, rhs: CGSector) -> Bool {
    return lhs.arc == rhs.arc
}

extension CGSector: CustomStringConvertible {
    public var description: String {
        return "CGSector(arc: \(arc))"
    }
}

