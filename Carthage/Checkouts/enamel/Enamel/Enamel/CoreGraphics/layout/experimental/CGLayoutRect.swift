//
//  CGLayoutRects.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 05/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public struct CGLayoutRect {
    public var origin: CGPoint
    public var size: CGLayoutSize
    
    public init(origin: CGPoint = .zero, size: CGLayoutSize) {
        self.origin = origin
        self.size = size
    }
    
    public init(origin: CGPoint = .zero, inner: CGSize = .zero, margin: CGOff = .zero, padding: CGOff = .zero) {
        self.init(
            origin: origin,
            size: CGLayoutSize(inner: inner, margin: margin, padding: padding)
        )
    }
    
    public init(aligned alignment: CGRect.Alignment, inside rect: CGLayoutRect, size: CGLayoutSize) {
        let spacing = max(
            size.margin.spacing(aligned: alignment),
            rect.size.margin.spacing(aligned: alignment)
        )
        let frame = CGRect(
            aligned: alignment,
            inside: rect.padded,
            size: size.padded,
            spacing: spacing
        )
        self.init(origin: frame.origin, size: size)
    }
    
    public init(aligned alignment: CGRect.Alignment, outside rect: CGLayoutRect, size: CGLayoutSize) {
        let spacing = max(
            size.margin.spacing(aligned: alignment.flipped),
            rect.size.margin.spacing(aligned: alignment)
        )
        let frame = CGRect(
            aligned: alignment,
            outside: rect.padded,
            size: size.padded,
            spacing: spacing
        )
        self.init(origin: frame.origin, size: size)
    }
}

public extension CGLayoutRect {
    public var inner: CGRect { return CGRect(origin: origin + size.padding, size: size.inner) }
    public var padded: CGRect { return CGRect(origin: origin, size: size.padded) }
    public var outer: CGRect { return padded + size.margin }
}

extension CGLayoutRect: SVG {
    public func add(to context: SVGContext) {
        context.rectangle(inner)
        context.rectangle(padded)
        context.rectangle(outer)
    }
}

