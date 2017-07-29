//
//  CGRect+NamedPoint.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 24/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public enum CGNamedPoint {
    
    case topLeft,    topCenter,    topRight
    case middleLeft, center,       middleRight
    case bottomLeft, bottomCenter, bottomRight
    
    public var anchor: CGPoint {
        #if GEOMETRY_NOT_FLIPPED
            switch self {
            case .topLeft:      return CGPoint(x: 0,   y: 1)
            case .topCenter:    return CGPoint(x: 0.5, y: 1)
            case .topRight:     return CGPoint(x: 1,   y: 1)
                
            case .middleLeft:   return CGPoint(x: 0,   y: 0.5)
            case .center:       return CGPoint(x: 0.5, y: 0.5)
            case .middleRight:  return CGPoint(x: 1,   y: 0.5)
                
            case .bottomLeft:   return CGPoint(x: 0,   y: 0)
            case .bottomCenter: return CGPoint(x: 0.5, y: 0)
            case .bottomRight:  return CGPoint(x: 1,   y: 0)
            }
        #else
            switch self {
            case .topLeft:      return CGPoint(x: 0,   y: 0)
            case .topCenter:    return CGPoint(x: 0.5, y: 0)
            case .topRight:     return CGPoint(x: 1,   y: 0)
                
            case .middleLeft:   return CGPoint(x: 0,   y: 0.5)
            case .center:       return CGPoint(x: 0.5, y: 0.5)
            case .middleRight:  return CGPoint(x: 1,   y: 0.5)
                
            case .bottomLeft:   return CGPoint(x: 0,   y: 1)
            case .bottomCenter: return CGPoint(x: 0.5, y: 1)
            case .bottomRight:  return CGPoint(x: 1,   y: 1)
            }
        #endif
        
    }
    
    public init?(_ anchor: CGPoint) {
        #if GEOMETRY_NOT_FLIPPED
            switch (anchor.x, anchor.y) {
            case (0,   1):   self = .topLeft
            case (0.5, 1):   self = .topCenter
            case (1,   1):   self = .topRight
                
            case (0,   0.5): self = .middleLeft
            case (0.5, 0.5): self = .center
            case (1,   0.5): self = .middleRight
                
            case (0,   0):   self = .bottomLeft
            case (0.5, 0):   self = .bottomCenter
            case (1,   0):   self = .bottomRight
            default:         return nil
            }
        #else
            switch (anchor.x, anchor.y) {
            case (0,   0):   self = .topLeft
            case (0.5, 0):   self = .topCenter
            case (1,   0):   self = .topRight
                
            case (0,   0.5): self = .middleLeft
            case (0.5, 0.5): self = .center
            case (1,   0.5): self = .middleRight
                
            case (0,   1):   self = .bottomLeft
            case (0.5, 1):   self = .bottomCenter
            case (1,   1):   self = .bottomRight
            default:         return nil
            }
        #endif
    }
    
    public func point(in size: CGSize) -> CGPoint {
        return CGRect(origin: .zero, size: size)
            .point(atAnchor: anchor)
    }
    
    public func point(in rect: CGRect) -> CGPoint {
        return rect.point(atAnchor: anchor)
    }
}

public extension CGRect {
    
    public func point(named namedPoint: CGNamedPoint) -> CGPoint {
        return point(atAnchor: namedPoint.anchor)
    }
    
    public var topLeft: CGPoint { return point(named: .topLeft) }
    public var topCenter: CGPoint { return point(named: .topCenter) }
    public var topRight: CGPoint { return point(named: .topRight) }
    
    public var middleLeft: CGPoint { return point(named: .middleLeft) }
    public var center: CGPoint {
        get { return CGPoint(x: midX, y: midY) }
        set { origin = newValue - size / 2 }
    }
    public var middleRight: CGPoint { return point(named: .middleRight) }
    
    public var bottomLeft: CGPoint { return point(named: .bottomLeft) }
    public var bottomCenter: CGPoint { return point(named: .bottomCenter) }
    public var bottomRight: CGPoint { return point(named: .bottomRight) }
}

public extension CGRect {
    
    public var minXminY: CGPoint { return CGPoint(x: minX, y: minY) }
    public var midXminY: CGPoint { return CGPoint(x: midX, y: minY) }
    public var maxXminY: CGPoint { return CGPoint(x: maxX, y: minY) }
    
    public var minXmidY: CGPoint { return CGPoint(x: minX, y: midY) }
    public var midXmidY: CGPoint { return CGPoint(x: midX, y: midY) }
    public var maxXmidY: CGPoint { return CGPoint(x: maxX, y: midY) }
    
    public var minXmaxY: CGPoint { return CGPoint(x: minX, y: maxY) }
    public var midXmaxY: CGPoint { return CGPoint(x: midX, y: maxY) }
    public var maxXmaxY: CGPoint { return CGPoint(x: maxX, y: maxY) }
}
