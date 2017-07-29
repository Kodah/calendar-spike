//
//  CoreGraphics.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 29/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import CoreGraphics

public enum CGGeometry {
    
    public static let isNotFlipped = !isFlipped
    
    #if GEOMETRY_NOT_FLIPPED
    public static let isFlipped = false
    #else
    public static let isFlipped = true
    #endif
}

public extension CGGeometry {
    
    public static let origin: Origin = isFlipped ? .topLeft : .bottomLeft
    
    public enum Origin {
        
        case topLeft
        case bottomLeft
        
        public func anchor(y: CGFloat) -> CGFloat {
            switch self {
            case .topLeft: return isFlipped ? y : 1 - y
            case .bottomLeft: return isFlipped ? 1 - y : y
            }
        }
    }
}

public extension CGGeometry {
    
    public static func isNotClockwiseTurn(from start: CGAngle, to end: CGAngle) -> Bool {
        return !isClockwiseTurn(from: start, to: end)
    }
    
    public static func isClockwiseTurn(from start: CGAngle, to end: CGAngle) -> Bool {
        return start > end
    }
}
