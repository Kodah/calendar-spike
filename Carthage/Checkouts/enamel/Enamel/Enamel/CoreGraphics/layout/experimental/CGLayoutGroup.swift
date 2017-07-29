//
//  CGLayoutGroup.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 05/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public struct CGLayoutGroup {
    
    public init(_ rects: [CGLayoutRect]) {
        self.rects = rects
    }
    
    public init<LayoutSizes>(
        aligning alignment: CGRect.Alignment,
        sizes: LayoutSizes,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero)
        where
        LayoutSizes: Sequence,
        LayoutSizes.Iterator.Element == CGLayoutSize
    {
        var rect = CGLayoutRect(origin: position)
        rects = sizes.map{ size in
            rect = CGLayoutRect(aligned: alignment, outside: rect, size: size)
            return rect
        }
    }
    
    fileprivate var rects: [CGLayoutRect]
}

public extension CGLayoutGroup {
    
    public var innerFrame: CGRect {
        return rects.map{ $0.inner }.union
    }
    
    public var paddedFrame: CGRect {
        return rects.map{ $0.padded }.union
    }
    
    public var outerFrame: CGRect {
        return rects.map{ $0.outer }.union
    }
}

extension CGLayoutGroup: RandomAccessCollection {
    public var startIndex: Int { return rects.startIndex }
    public var endIndex: Int { return rects.endIndex }
    public func index(after i: Int) -> Int { return rects.index(after: i) }
    public func index(before i: Int) -> Int { return rects.index(before: i) }
    public subscript(i: Int) -> CGLayoutRect { return rects[i] }
}

extension CGLayoutGroup: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: CGLayoutRect...) {
        self.init(elements)
    }
}

extension CGLayoutGroup: SVG {
    public func add(to context: SVGContext) {
        rects.forEach{ $0.add(to: context) }
    }
}
