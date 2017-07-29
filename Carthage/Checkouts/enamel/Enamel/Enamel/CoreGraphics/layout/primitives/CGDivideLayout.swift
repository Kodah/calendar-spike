//
//  CGDivideLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 27/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public struct CGDivideLayout {
    
    public enum By {
        case distance(CGFloat)
        case slice
    }
    
    public let by: By
    public let edge: CGRectEdge
    public let spacing: CGFloat
    
    public let slice: CGLayout
    public let remainder: CGLayout
    
    public init(
        atDistance distance: CGFloat,
        from edge: CGRectEdge,
        spacing: CGFloat = 0,
        slice: CGLayout,
        remainder: CGLayout)
    {
        self.by = .distance(distance)
        self.edge = edge
        self.spacing = spacing
        self.slice = slice
        self.remainder = remainder
    }
    
    public init(
        from edge: CGRectEdge,
        spacing: CGFloat = 0,
        slice: CGLayout,
        remainder: CGLayout)
    {
        self.by = .slice
        self.edge = edge
        self.spacing = spacing
        self.slice = slice
        self.remainder = remainder
    }
}

extension CGDivideLayout: CGLayout {
    
    public var childLayouts: [CGLayout] { return [slice, remainder] }
    
    public func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    public func arrange(in rect: CGRect) {
        let divided = divide(in: rect)
        slice.arrange(in: divided.slice)
        remainder.arrange(in: divided.remainder)
    }
}

extension CGDivideLayout: CGLayoutAlongAxis {
    
    public var layoutAxis: CGLayoutAxis { return edge.layoutAxis }
}

fileprivate extension CGDivideLayout {
    
    func distance(toFit size: CGSize) -> CGFloat {
        switch by {
        case .distance(let distance): return distance
        case .slice: return slice.size(toFit: size).along(layoutAxis)
        }
    }
    
    func divide(in rect: CGRect) -> (slice: CGRect, remainder: CGRect) {
        let distance = self.distance(toFit: rect.size)
        let dividied = rect.divided(atDistance: distance, from: edge)
        return (
            dividied.slice,
            dividied.remainder.divided(atDistance: spacing, from: edge).remainder
        )
    }
}

