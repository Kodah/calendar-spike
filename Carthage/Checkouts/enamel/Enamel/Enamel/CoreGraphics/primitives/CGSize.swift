//
//  CGSize.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

// MARK:- Static constants

public extension CGSize {
    
    public static let unit = CGSize(width: 1, height: 1)
    public static let greatestFiniteSize = CGSize(square: .greatestFiniteMagnitude)
    public static let infinity = CGSize(square: .infinity)
}

// MARK:- vars

public extension CGSize {
    
    public var min: CGFloat { return width < height ? width : height }
    public var max: CGFloat { return width > height ? width : height }
    public var area: CGFloat { return width * height }
    public var hasArea: Bool { return area > 0 }
    public var diagonal: CGFloat { return hypot(width, height) }
    
    /// Synonimous to `widthToHeightRatio`
    public var aspectRatio: CGFloat? { return widthToHeightRatio }
    public var widthToHeightRatio: CGFloat? { return (width / height).ifOK }
    public var heightToWidthRatio: CGFloat? { return (height / width).ifOK }
    
    public var isVertical: Bool { return height > width }
    public var isHorizontal: Bool { return width < height }
}

// MARK:- named points

public extension CGSize {
    
    public var center:      CGPoint { return CGPoint(x: width / 2, y: height / 2) }
    public var centerLeft:  CGPoint { return CGPoint(x: 0,         y: height / 2) }
    public var centerRight: CGPoint { return CGPoint(x: width,     y: height / 2) }
    
    public var minXminY: CGPoint { return CGPoint(x: 0,         y: 0) }
    public var midXminY: CGPoint { return CGPoint(x: width / 2, y: 0) }
    public var maxXminY: CGPoint { return CGPoint(x: width,     y: 0) }
    
    public var minXmidY: CGPoint { return CGPoint(x: 0,         y: height / 2) }
    public var midXmidY: CGPoint { return CGPoint(x: width / 2, y: height / 2) }
    public var maxXmidY: CGPoint { return CGPoint(x: width,     y: height / 2) }
    
    public var minXmaxY: CGPoint { return CGPoint(x: 0,         y: height) }
    public var midXmaxY: CGPoint { return CGPoint(x: width / 2, y: height) }
    public var maxXmaxY: CGPoint { return CGPoint(x: width,     y: height) }
}

// MARK:- init

public extension CGSize {
    
    public init(square width: CGFloat) {
        self.width = width
        self.height = width
    }
}

// MARK:- to rect

public extension CGSize {
    
    public func rect(origin: CGPoint = .zero) -> CGRect {
        return CGRect(origin: origin, size: self)
    }
    
    public func rect(center: CGPoint) -> CGRect {
        return CGRect(center: center, size: self)
    }
}

// MARK:- combining sizes

public extension CGSize {
    
    /**
     - note: Converts all lenghts to their absolute values.
     */
    public func union(_ other: CGSize) -> CGSize {
        return CGSize(
            width: Swift.max(width.abs, other.width.abs),
            height: Swift.max(height.abs, other.height.abs)
        )
    }
}

public extension Sequence where Iterator.Element == CGSize {
    
    /**
     - note: Converts all lenghts to their absolute values.
     */
    public var union: CGSize {
        return reduce(CGSize.union) ?? .zero
    }
}

// MARK:- align

public extension CGSize {
    
    public func rect(aligned: CGRect.Alignment, outside rect: CGRect, spacing: CGFloat = 0) -> CGRect {
        return CGRect(aligned: aligned, outside: rect, size: self, spacing: spacing)
    }
    
    public func rect(aligned: CGRect.Alignment, inside rect: CGRect, spacing: CGFloat = 0) -> CGRect {
        return CGRect(aligned: aligned, inside: rect, size: self, spacing: spacing)
    }
}

public extension Sequence where Iterator.Element == CGSize {
    
    public func rects(
        aligned alignment: CGRect.Alignment,
        anchor anchorName: CGNamedPoint,
        position: CGPoint = .zero,
        padding: CGOff = .zero,
        spacing: CGFloat = 0)
        -> CGRectGroup
    {
        return CGRectGroup(
            aligning: alignment,
            sizes: self,
            anchor: anchorName.anchor,
            position: position,
            padding: padding,
            spacing: spacing
        )
    }
    
    public func rects(
        aligned alignment: CGRect.Alignment,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero,
        padding: CGOff = .zero,
        spacing: CGFloat = 0)
        -> CGRectGroup
    {
        return CGRectGroup(
            aligning: alignment,
            sizes: self,
            anchor: anchor,
            position: position,
            padding: padding,
            spacing: spacing
        )
    }
    
    public func rects(
        justified alignment: CGRect.Alignment,
        toFit space: CGFloat,
        anchor namedPoint: CGNamedPoint,
        position: CGPoint = .zero,
        padding: CGOff = .zero)
        -> CGRectGroup
    {
        return CGRectGroup(
            justified: alignment,
            sizes: self,
            toFit: space,
            anchor: namedPoint.anchor,
            position: position,
            padding: padding
        )
    }
    
    public func rects(
        justified alignment: CGRect.Alignment,
        toFit space: CGFloat,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero,
        padding: CGOff = .zero)
        -> CGRectGroup
    {
        return CGRectGroup(
            justified: alignment,
            sizes: self,
            toFit: space,
            anchor: anchor,
            position: position,
            padding: padding
        )
    }
}

// MARK:- Grid

public extension CGSize {
    
    public func grid(rows: Int, cols: Int, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGGrid {
        return CGRect(origin: .zero, size: self).grid(rows: rows, cols: cols, padding: padding, spacing: spacing)
    }
    
    public func tiled(rows: Int = 1, cols: Int = 1, origin: CGPoint = .zero, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGGrid {
        return CGGrid(tile: self, origin: origin, rows: rows, cols: cols, padding: padding, spacing: spacing) 
    }
    
    public func tiled(rows: Int = 1, cols: Int = 1, center: CGPoint, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGGrid {
        var grid = tiled(rows: rows, cols: cols, padding: padding, spacing: spacing)
        grid.frame.center = center
        return grid
    }
}

// MARK:- Scale & resize
 
public extension CGSize {
    
    public func with(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
        return CGSize(
            width: width ?? self.width,
            height: height ?? self.height
        )
    }
    
    /**
     - returns: a scaling factor such that `self.abs` multiplied by it would result in a size that fits into `size.abs`. In other words, this is always a positive value, even if some of the dimensions of the two sizes are not.
     */
    public func scale(toFit size: CGSize) -> CGFloat? {
        let (a, b) = (abs, size.abs)
        return fmin(b.width / a.width, b.height / a.height).ifOK
    }
    
    public func size(toFit size: CGSize) -> CGSize? {
        return scale(toFit: size).map{ (self * $0).abs }
    }
}

// MARK:- Conformances

extension CGSize: CGTuple2Convertible {
    public var tuple: (CGFloat, CGFloat) { return (width, height) }
    public init(_ tuple: CGTuple2) { width = tuple.0; height = tuple.1 }
}

extension CGSize: CustomStringConvertible {
    public var description: String { return "CGSize(width: \(width), height: \(height))" }
}
