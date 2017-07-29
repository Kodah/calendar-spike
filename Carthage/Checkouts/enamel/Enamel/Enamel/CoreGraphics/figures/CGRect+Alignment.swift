//
//  CGRect+Alignment.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 04/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public extension CGRect {
    
    public enum Alignment {
        
        case top(Vertical)
        case bottom(Vertical)
        case center
        case left(Horizontal)
        case right(Horizontal)
        
        public enum Vertical {
            case left, center, right
        }
        
        public enum Horizontal {
            case top, center, bottom
        }
    }
}

public extension CGRect.Alignment {
    
    public var isVertical: Bool {
        switch self {
        case .top, .bottom: return true
        default: return false
        }
    }
    
    public var isHorizontal: Bool {
        switch self {
        case .left, .right: return true
        default: return false
        }
    }
    
    public var flipped: CGRect.Alignment {
        switch self {
        case let .top(o): return .bottom(o)
        case let .bottom(o): return .top(o)
        case .center: return .center
        case let .left(o): return .right(o)
        case let .right(o): return .left(o)
        }
    }
    
    public var namedPoint: CGNamedPoint {
        switch self {
        case .top(.left): return .topLeft
        case .top(.center): return .topCenter
        case .top(.right): return .topRight
            
        case .bottom(.left): return .bottomLeft
        case .bottom(.center): return .bottomCenter
        case .bottom(.right): return .bottomRight
            
        case .center: return .center
            
        case .left(.top): return .topLeft
        case .left(.center): return .middleLeft
        case .left(.bottom): return .bottomLeft
            
        case .right(.top): return .topRight
        case .right(.center): return .middleRight
        case .right(.bottom): return .bottomRight
        }
    }
    
    public var anchor: CGPoint {
        return namedPoint.anchor
    }
    
    public var spacingSign: CGTuple2 {
        switch self {
        case .top: return (0, CGGeometry.isFlipped ? 1 : -1)
        case .bottom: return (0, CGGeometry.isFlipped ? -1 : 1)
        case .center: return (0, 0)
        case .left: return (1, 0)
        case .right: return (-1, 0)
        }
    }
}

