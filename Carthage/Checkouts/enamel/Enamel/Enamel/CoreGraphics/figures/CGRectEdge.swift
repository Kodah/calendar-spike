//
//  CGRectEdge.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 24/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public extension CGRectEdge {
    
    public var isVertical: Bool {
        switch self {
        case .minXEdge, .maxXEdge: return false
        case .minYEdge, .maxYEdge: return true
        }
    }
    
    public var isHorizontal: Bool {
        switch self {
        case .minXEdge, .maxXEdge: return false
        case .minYEdge, .maxYEdge: return true
        }
    }
}

public extension CGRectEdge {
    
    public var opposite: CGRectEdge {
        switch self
        {
        case .minXEdge: return .maxXEdge
        case .maxXEdge: return .minXEdge
        case .minYEdge: return .maxYEdge
        case .maxYEdge: return .minYEdge
        }
    }
}

public extension CGRectEdge {
    
    public static var left: CGRectEdge { return .minXEdge }
    public static var right: CGRectEdge { return .maxXEdge }
    
    #if GEOMETRY_NOT_FLIPPED
    public static var top: CGRectEdge { return .maxYEdge }
    public static var bottom: CGRectEdge { return .minYEdge }
    #else
    public static var top: CGRectEdge { return .minYEdge }
    public static var bottom: CGRectEdge { return .maxYEdge }
    #endif
}

public extension CGRectEdge {
    
    /// Halway point along the edge
    public var anchor: CGPoint {
        #if GEOMETRY_NOT_FLIPPED
            switch self {
            case .minXEdge: return CGNamedPoint.middleLeft.anchor
            case .maxXEdge: return CGNamedPoint.middleRight.anchor
            case .maxYEdge: return CGNamedPoint.topCenter.anchor
            case .minYEdge: return CGNamedPoint.bottomCenter.anchor
            }
        #else
            switch self {
            case .minXEdge: return CGNamedPoint.middleLeft.anchor
            case .maxXEdge: return CGNamedPoint.middleRight.anchor
            case .maxYEdge: return CGNamedPoint.bottomCenter.anchor
            case .minYEdge: return CGNamedPoint.topCenter.anchor
            }
        #endif
    }
}
