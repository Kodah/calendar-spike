//
//  CGLayoutSizes.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 05/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public struct CGLayoutSize {
    public var inner: CGSize
    public var margin: CGOff = .zero
    public var padding: CGOff = .zero
    
    public init(inner: CGSize = .zero, margin: CGOff = .zero, padding: CGOff = .zero) {
        (self.inner, self.margin, self.padding) = (inner, margin, padding)
    }
    
    public init(width: CGFloat, height: CGFloat, margin: CGOff = .zero, padding: CGOff = .zero) {
        (self.inner, self.margin, self.padding) = (CGSize(width: width, height: height), margin, padding)
    }
}

public extension CGLayoutSize {
    public static let zero = CGLayoutSize()
}

public extension CGLayoutSize {
    public var padded: CGSize { return inner + padding }
    public var outter: CGSize { return padded + margin }
}

public extension Sequence where Iterator.Element == CGLayoutSize {
    
    public func rects(
        aligned alignment: CGRect.Alignment,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero)
        -> CGLayoutGroup
    {
        return CGLayoutGroup(
            aligning: alignment,
            sizes: self,
            anchor: anchor,
            position: position
        )
    }
}
