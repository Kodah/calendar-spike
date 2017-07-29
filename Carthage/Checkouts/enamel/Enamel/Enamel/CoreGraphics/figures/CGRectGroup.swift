//
//  CGRectCollection.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 04/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public struct CGRectGroup {
    
    public static let zero = CGRectGroup()
    
    public var frame: CGRect { return CGRect(origin: origin, size: size) }
    
    public var origin: CGPoint {
        didSet {
            guard origin != oldValue else { return }
            let offset = origin - oldValue
            for i in rects.indices {
                rects[i].origin = rects[i].origin + offset
            }
        }
    }
    
    public fileprivate(set) var size: CGSize
    
    public init<Rects>(_ rects: Rects, frame: CGRect? = nil)
        where
        Rects: Sequence,
        Rects.Iterator.Element == CGRect
    {
        let rects = Array(rects)
        let rect = frame ?? rects.union
        self.origin = rect.origin
        self.size = rect.size
        self.rects = rects
    }
    
    fileprivate var rects: [CGRect]
}

public extension CGRectGroup {
    
    public init<Sizes>(
        aligning alignment: CGRect.Alignment,
        sizes: Sizes,
        anchor anchorName: CGNamedPoint,
        position: CGPoint = .zero,
        padding: CGOff = .zero,
        spacing: CGFloat = 0)
        where
        Sizes: Sequence,
        Sizes.Iterator.Element == CGSize
    {
        self.init(
            aligning: alignment,
            sizes: sizes,
            anchor: anchorName.anchor,
            position: position,
            padding: padding,
            spacing: spacing
        )
    }
    
    public init<Sizes>(
        aligning alignment: CGRect.Alignment,
        sizes: Sizes,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero,
        padding: CGOff = .zero,
        spacing: CGFloat = 0)
        where
        Sizes: Sequence,
        Sizes.Iterator.Element == CGSize
    {
        var prev: CGRect = .zero
        let rects = sizes.map{ size -> CGRect in
            prev = CGRect(
                aligned: alignment,
                outside: prev,
                size: size,
                spacing: prev.size == .zero ? 0 : spacing
            )
            return prev
        }
        self = CGRectGroup(rects, frame: rects.union + padding)
            .aligned(anchor: anchor, position: position)
    }
    
    public init<Sizes>(
        justified alignment: CGRect.Alignment,
        sizes: Sizes,
        toFit space: CGFloat,
        anchor namedPoint: CGNamedPoint,
        position: CGPoint = .zero,
        padding: CGOff = .zero)
        where
        Sizes: Sequence,
        Sizes.Iterator.Element == CGSize
    {
        self.init(
            justified: alignment,
            sizes: sizes,
            toFit: space,
            anchor: namedPoint.anchor,
            position: position,
            padding: padding
        )
    }
    
    public init<Sizes>(
        justified alignment: CGRect.Alignment,
        sizes: Sizes,
        toFit space: CGFloat,
        anchor: CGPoint = .zero,
        position: CGPoint = .zero,
        padding: CGOff = .zero)
        where
        Sizes: Sequence,
        Sizes.Iterator.Element == CGSize
    {
        let pack = CGRectGroup(aligning: alignment, sizes: sizes)
        let packedSpace = alignment.isHorizontal ? pack.size.width : pack.size.height
        let spacing = pack.count > 1 ? (space - packedSpace) / (pack.count - 1).cg : 0
        self.init(
            aligning: alignment,
            sizes: sizes,
            anchor: anchor,
            position: position,
            padding: padding,
            spacing: spacing
        )
    }
}

public extension CGRectGroup {
    
    public mutating func align(anchor: CGPoint, position: CGPoint) {
        let offset = position - frame.point(atAnchor: anchor)
        origin = origin + offset
    }
    
    public func aligned(anchor: CGPoint, position: CGPoint) -> CGRectGroup {
        var o = self
        o.align(anchor: anchor, position: position)
        return o
    }
}

public extension CGRectGroup {
    
    public func scaledBy(factor: CGFloat, anchor: CGPoint = .unit / 2) -> CGRectGroup {
        return scaledBy(factor: factor, relativeTo: frame.point(atAnchor: anchor))
    }
    
    public func scaledBy(factor: CGFloat, relativeTo point: CGPoint) -> CGRectGroup {
        let rects = map{ $0.scaledBy(factor: factor, relativeTo: point) }
        let frame = self.frame.scaledBy(factor: factor, relativeTo: point)
        return CGRectGroup(rects, frame: frame)
    }
}

public extension Sequence where Iterator.Element == CGRect {
    
    public func group(withFrame frame: CGRect? = nil) -> CGRectGroup {
        return CGRectGroup(self, frame: frame)
    }
}

public extension Sequence where Iterator.Element == CGRect {
    
    public var group: CGRectGroup { return CGRectGroup(self) }
}

extension CGRectGroup: RandomAccessCollection {
    public var startIndex: Int { return rects.startIndex }
    public var endIndex: Int { return rects.endIndex }
    public func index(after i: Int) -> Int { return rects.index(after: i) }
    public func index(before i: Int) -> Int { return rects.index(before: i) }
}

extension CGRectGroup: RangeReplaceableCollection {
    
    public init() {
        self.init([])
    }
    
    public subscript(i: Int) -> CGRect {
        get{ return rects[i] }
        set{ rects[i] = newValue }
    }
    
    public mutating func replaceSubrange<C>(
        _ subrange: Range<Int>,
        with newElements: C)
        where
        C : Collection,
        C.Iterator.Element == CGRect
    {
        rects.replaceSubrange(subrange, with: newElements)
    }
}

extension CGRectGroup: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: CGRect...) {
        self.init(elements)
    }
}

extension CGRectGroup: SVG {
    public func add(to context: SVGContext) {
        context.rectangle(frame)
        rects.forEach{ context.rectangle($0) }
    }
}

extension CGRectGroup: CustomStringConvertible {
    public var description: String {
        return "\(type(of: self))(count: \(count), frame: \(frame))"
    }
}
