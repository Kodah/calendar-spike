//
//  CGOffsets.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 05/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public typealias CGOffsets = CGOff

public struct CGOff {
    public var top: CGFloat
    public var right: CGFloat
    public var bottom: CGFloat
    public var left: CGFloat
    
    public init(top: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, left: CGFloat = 0) {
        (self.top, self.right, self.bottom, self.left) = (top, right, bottom, left)
    }
}

public extension CGOff {
    
    public init(hor: CGFloat, ver: CGFloat) {
        self.init(horizontal: hor, vertical: ver)
    }
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, right: horizontal, bottom: vertical, left: horizontal)
    }
    
    public init(ver: CGFloat) {
        self.init(vertical: ver)
    }
    
    public init(vertical: CGFloat) {
        self.init(top: vertical, right: 0, bottom: vertical, left: 0)
    }
    
    public init(hor: CGFloat) {
        self.init(horizontal: hor)
    }
    
    public init(horizontal: CGFloat) {
        self.init(top: 0, right: horizontal, bottom: 0, left: horizontal)
    }
    
    public init(all offset: CGFloat) {
        self.init(top: offset, right: offset, bottom: offset, left: offset)
    }
}

extension CGOff {
    
    public func with(
        top: CGFloat? = nil,
        right: CGFloat? = nil,
        bottom: CGFloat? = nil,
        left: CGFloat? = nil
        ) -> CGOff
    {
        return CGOff(
            top: top ?? self.top,
            right: right ?? self.right,
            bottom: bottom ?? self.bottom,
            left: left ?? self.left
        )
    }
}

extension CGOff: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(all: value.cg)
    }
}

public extension CGOff {

    public static let zero = CGOff(top: 0, right: 0, bottom: 0, left: 0)
    public static let unit = CGOff(top: 1, right: 1, bottom: 1, left: 1)
}

public extension CGOff {
    
    public var vertical: CGFloat { return top + bottom }
    public var horizontal: CGFloat { return left + right }
}

public extension CGOff {
    
    public subscript(_ edge: CGRectEdge) -> CGFloat {
        get {
            switch edge {
            case .minYEdge: return CGGeometry.isFlipped ? top : bottom
            case .maxYEdge: return CGGeometry.isFlipped ? bottom : top
            case .minXEdge: return left
            case .maxXEdge: return right
            }
        }
        set {
            switch edge {
            case .minYEdge:
                if CGGeometry.isFlipped {
                    top = newValue
                } else {
                    bottom = newValue
                }
            case .maxYEdge:
                if CGGeometry.isFlipped {
                    bottom = newValue
                } else {
                    top = newValue
                }
            case .minXEdge: left = newValue
            case .maxXEdge: right = newValue
            }
        }
    }
    
    public func offset(at alignment: CGRect.Alignment) -> CGVector {
        let o: CGTuple2
        switch alignment
        {
        case .top(.left): o = (left, top)
        case .top(.center): o = (0, top)
        case .top(.right): o = (-right, top)
            
        case .bottom(.left): o = (left, -bottom)
        case .bottom(.center): o = (0, -bottom)
        case .bottom(.right): o = (-right, -bottom)
            
        case .center: o = (0, 0)
            
        case .left(.top): o = (left, top)
        case .left(.center): o = (left, 0)
        case .left(.bottom): o = (left, -bottom)
            
        case .right(.top): o = (-right, top)
        case .right(.center): o = (-right, 0)
        case .right(.bottom): o = (-right, -bottom)
        }
        return CGVector(dx: o.0, dy: o.1 * (CGGeometry.isFlipped ? 1 : -1))
    }
    
    public func spacing(aligned alignment: CGRect.Alignment) -> CGFloat {
        switch alignment {
        case .top: return top
        case .bottom: return bottom
        case .center: return 0
        case .left: return left
        case .right: return right
        }
    }
}

public extension CGOff {
    
    public static func + (lhs: CGPoint, rhs: CGOff) -> CGPoint {
        return CGPoint(
            x: lhs.x + rhs.left,
            y: lhs.y + (CGGeometry.isFlipped ? rhs.top : rhs.bottom)
        )
    }
    
    public static func + (lhs: CGSize, rhs: CGOff) -> CGSize {
        return lhs + (rhs.left + rhs.right, rhs.top + rhs.bottom)
    }
    
    public static func + (lhs: CGRect, rhs: CGOff) -> CGRect {
        return CGRect(origin: lhs.origin - rhs, size: lhs.size + rhs)
    }
}

public extension CGOff {
    
    public static func - (lhs: CGPoint, rhs: CGOff) -> CGPoint {
        return CGPoint(
            x: lhs.x - rhs.left,
            y: lhs.y - (CGGeometry.isFlipped ? rhs.top : rhs.bottom)
        )
    }
    
    public static func - (lhs: CGSize, rhs: CGOff) -> CGSize {
        return lhs - (rhs.left + rhs.right, rhs.top + rhs.bottom)
    }
    
    public static func - (lhs: CGRect, rhs: CGOff) -> CGRect {
        return CGRect(origin: lhs.origin + rhs, size: lhs.size - rhs)
    }
}

public extension CGOff {
    
    public static func + (lhs: CGOff, rhs: CGOff) -> CGOff {
        return CGOff(
            top: lhs.top + rhs.top,
            right: lhs.right + rhs.right,
            bottom: lhs.bottom + rhs.bottom,
            left: lhs.left + rhs.left
        )
    }
    
    public static func - (lhs: CGOff, rhs: CGOff) -> CGOff {
        return CGOff(
            top: lhs.top - rhs.top,
            right: lhs.right - rhs.right,
            bottom: lhs.bottom - rhs.bottom,
            left: lhs.left - rhs.left
        )
    }
}

public extension CGOff {
    
    public static func + (lhs: CGOff, rhs: CGFloat) -> CGOff {
        return CGOff(
            top: lhs.top + rhs,
            right: lhs.right + rhs,
            bottom: lhs.bottom + rhs,
            left: lhs.left + rhs
        )
    }
    
    public static func - (lhs: CGOff, rhs: CGFloat) -> CGOff {
        return CGOff(
            top: lhs.top - rhs,
            right: lhs.right - rhs,
            bottom: lhs.bottom - rhs,
            left: lhs.left - rhs
        )
    }
    
    public static func * (lhs: CGOff, rhs: CGFloat) -> CGOff {
        return CGOff(
            top: lhs.top * rhs,
            right: lhs.right * rhs,
            bottom: lhs.bottom * rhs,
            left: lhs.left * rhs
        )
    }
    
    public static func / (lhs: CGOff, rhs: CGFloat) -> CGOff {
        return CGOff(
            top: lhs.top / rhs,
            right: lhs.right / rhs,
            bottom: lhs.bottom / rhs,
            left: lhs.left / rhs
        )
    }
}

