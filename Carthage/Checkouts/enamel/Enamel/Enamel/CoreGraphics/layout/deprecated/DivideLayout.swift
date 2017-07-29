//
//  CanLayout.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 23/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public struct DivideLayout<Slice: CanLayout, Rest: CanLayout>: CanLayout {
    
    public var slice: Slice
    public var rest: Rest
    public var distance: CGFloat
    public var edge: CGRectEdge
    public var padding: CGFloat
    public var spacing: CGFloat
    
    public init(
        slice: Slice,
        rest: Rest,
        distance: CGFloat,
        edge: CGRectEdge,
        padding: CGFloat = 0,
        spacing: CGFloat = 0)
    {
        self.slice = slice
        self.rest = rest
        self.distance = distance
        self.edge = edge
        self.padding = padding
        self.spacing = spacing
    }
    
    @discardableResult
    public func layout(in rect: CGRect) -> DivideLayout {
        let rect = rect.insetBy(margin: padding)
        let (sliceFrame, _) = rect.divided(atDistance: distance - spacing / 2, from: edge)
        let (_, restFrame) = rect.divided(atDistance: distance + spacing / 2, from: edge)
        slice.layout(in: sliceFrame)
        rest.layout(in: restFrame)
        return self
    }
}
