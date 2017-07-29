//
//  CGTick.swift
//  Enamel
//
//  Created by Agno, Edgardo (Developer) on 11/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public struct CGTick {
    
    let frame: CGRect
    
    let start: CGPoint
    let middle: CGPoint
    let end: CGPoint
    
    public init(rect: CGRect) {
        let size = CGSize(width: 3, height: 2)
            .size(toFit: rect.size) ?? .zero
        
        frame = CGRect(center: rect.center, size: size)
        start = frame.middleLeft
        middle = frame.pointAtAnchor(x: 1.0 / 3, y: 0, from: .bottomLeft)
        end = frame.topRight
    }
}

extension CGTick: Equatable {
    public static func == (lhs: CGTick, rhs: CGTick) -> Bool {
        return lhs.frame == rhs.frame
    }
}

extension CGTick: SVG {
    public func add(to context: SVGContext) {
        CGPolygon(vertices: [start, middle, end], open: true)
            .add(to: context)
    }
}

extension CGTick: CustomStringConvertible {
    public var description: String {
        return "CGTick(frame: \(frame))"
    }
}
