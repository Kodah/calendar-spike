//
//  CGRect.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- static constants

public extension CGRect {
    
    public static let unit = CGRect(origin: .zero, size: .unit)
}

// MARK:- Other vars

public extension CGRect {
    
    public var x: CGFloat { return origin.x }
    public var y: CGFloat { return origin.y }
    
    public var area: CGFloat { return width * height }
    public var diagonal: CGFloat { return size.diagonal }
    
    public var isVertical: Bool { return height > width }
    public var isHorizontal: Bool { return width < height }
}

extension CGRect {
    
    public var excircle: CGCircle { return CGCircle(center: center, radius: diagonal / 2) }
    public var inellipse: CGEllipse { return CGEllipse(center: center, xRadius: width / 2, yRadius: height / 2) }

    public func incircle(aligned alignment: Alignment = .center) -> CGCircle {
        let diameter = size.min
        let square = CGSize(square: diameter).rect(aligned: alignment, inside: self)
        return CGCircle(center: square.center, radius: diameter / 2)
    }
}

// MARK:- init

public extension CGRect {
    
    public init(width: CGFloat, height: CGFloat) {
        self.init(
            origin: .zero,
            size: CGSize(width: width, height: height)
        )
    }
    
    public init(origin: CGPoint = .zero, square sideLength: CGFloat) {
        self.init(
            origin: origin,
            size: CGSize(width: sideLength, height: sideLength)
        )
    }
    
    public init(center: CGPoint, square sideLength: CGFloat) {
        self.init(
            center: center,
            size: CGSize(square: sideLength)
        )
    }
    
    public init(center: CGPoint, size: CGSize) {
        self.init(
            origin: center.offsetBy(size / -2),
            size: size
        )
    }
}

public extension CGRect {
    
    public init(anchor: CGPoint, position: CGPoint, size: CGSize) {
        self.init(
            origin: position - size * anchor,
            size: size
        )
    }
    
    public init(anchor: CGNamedPoint, position: CGPoint, size: CGSize) {
        self.init(
            origin: position - size * anchor.anchor,
            size: size
        )
    }
}

public extension CGRect {
    
    public init(aligned: Alignment, inside rect: CGRect, size: CGSize, spacing: CGFloat = 0) {
        self.init(
            anchor: aligned.namedPoint,
            position: rect.point(named: aligned.namedPoint) + aligned.spacingSign * spacing,
            size: size
        )
    }
    
    public init(aligned: Alignment, outside rect: CGRect, size: CGSize, spacing: CGFloat = 0) {
        self.init(
            anchor: aligned.flipped.anchor,
            position: rect.point(named: aligned.namedPoint) + aligned.flipped.spacingSign * spacing,
            size: size
        )
    }
}

// MARK:- .with...

public extension CGRect {
    
    public func with(
        x: CGFloat? = nil,
        y: CGFloat? = nil,
        width: CGFloat? = nil,
        height: CGFloat? = nil)
        -> CGRect
    {
        return CGRect(
            origin: CGPoint(x: x ?? origin.x, y: y ?? origin.y),
            size: CGSize(width: width ?? size.width, height: height ?? size.height)
        )
    }
    
    public func with(
        origin: CGPoint? = nil,
        size: CGSize? = nil)
        -> CGRect
    {
        return CGRect(origin: origin ?? self.origin, size: size ?? self.size)
    }
}

// MARK:- Anchor

public extension CGRect {
    
    public func point(atAnchor anchor: CGPoint, from: CGGeometry.Origin? = nil) -> CGPoint {
        return pointAtAnchor(x: anchor.x, y: anchor.y, from: from)
    }
    
    public func pointAtAnchor(x: CGFloat, y: CGFloat, from: CGGeometry.Origin? = nil) -> CGPoint {
        return CGPoint (
            x: origin.x + size.width * x,
            y: origin.y + size.height * (from?.anchor(y: y) ?? y)
        )
    }
    
    /// Returns `0.5` for each side of zero length.
    public func anchor(at point: CGPoint, from: CGGeometry.Origin? = nil) -> CGPoint {
        let x = width == 0 ? 0.5 : (point.x - origin.x) / width
        let y = height == 0 ? 0.5 : (point.y - origin.y) / height
        return CGPoint(x: x, y: from?.anchor(y: y) ?? y)
    }
}

// MARK:- Scaling

public extension CGRect {
    
    public func insetBy(margin: CGFloat) -> CGRect {
        return insetBy(dx: margin, dy: margin)
    }
    
    public func expandedBy(margin: CGFloat) -> CGRect {
        return insetBy(dx: -margin, dy: -margin)
    }
    
    public func expandedBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGRect {
        return insetBy(dx: -dx, dy: -dx)
    }
    
    public func scaledBy(factor: CGFloat, anchor: CGPoint = .unit / 2) -> CGRect {
        return scaledBy(factor: factor, relativeTo: point(atAnchor: anchor))
    }
    
    public func scaledBy(factor: CGFloat, relativeTo point: CGPoint) -> CGRect {
        return CGRect(
            origin: origin + (point - origin) * (1 - factor),
            size: size * factor
        )
    }
}

// MARK:- Grid

public extension CGRect {
    
    public func grid(rows: Int = 1, cols: Int = 1, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGGrid {
        return CGGrid(frame: self, rows: rows, cols: cols, padding: padding, spacing: spacing)
    }
    
    public func tiled(rows: Int = 1, cols: Int = 1, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGGrid {
        return CGGrid(tile: size, origin: origin - padding, rows: rows, cols: cols, padding: padding, spacing: spacing)
    }
}

// MARK:- sequences

public extension Sequence where Iterator.Element == CGRect {
    
    public var union: CGRect { return reduce(CGRect.union) ?? .zero }
    
    public func scaledBy(factor: CGFloat, relativeTo point: CGPoint) -> [CGRect] {
        return map{ $0.scaledBy(factor: factor, relativeTo: point) }
    }
}

// MARK:- Conformances

extension CGRect: SVG {
    public func add(to context: SVGContext) {
        context.rectangle(self)
    }
}

extension CGRect: CustomStringConvertible {
    public var description: String { return "CGRect(x: \(origin.x), y: \(origin.y), width: \(width), height: \(height))" }
}

