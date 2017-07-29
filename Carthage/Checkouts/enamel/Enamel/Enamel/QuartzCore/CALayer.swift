//
//  CALayer.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 14/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CALayer {
    
    public func addSublayers(layers: CALayer...) {
        addSublayers(layers)
    }
    
    public func addSublayers(_ layers: [CALayer]) {
        layers.forEach(addSublayer)
    }
    
    public func layout(at position: CGPoint, anchor: CGNamedPoint, size: CGSize? = nil) {
        layout(at: position, anchor: anchor.anchor, size: size)
    }
    
    public func layout(at position: CGPoint, anchor: CGPoint, size: CGSize? = nil) {
        self.anchorPoint = anchor
        self.position = position
        let oldBounds = bounds
        bounds = CGRect(origin: .zero, size: size ?? oldBounds.size)
        if bounds != oldBounds {
            layoutSublayers()
        }
    }
}

// MARK:- Space conversions

public extension CALayer {
    
    public func convert(circle: CGCircle, from layer: CALayer?) -> CGCircle {
        guard let layer = layer else { return circle }
        return convert(circle.frame, from: layer).incircle()
    }
    
    public func convert(circle: CGCircle, to layer: CALayer?) -> CGCircle {
        guard let layer = layer else { return circle }
        return convert(circle.frame, to: layer).incircle()
    }
}

// MARK:- CustomPlaygroundQuickLookable

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

extension CALayer: CustomPlaygroundQuickLookable {
    
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        guard bounds.size.hasArea else {
            return .text("Zero area \(type(of: self))")
        }
        #if os(iOS)
            
            frame = bounds
            let view = UIView(frame: bounds)
            view.layer.addSublayer(self)
            return .view(view)
            
        #elseif os(OSX)
            
            let view = NSView(frame: frame)
            view.layer = self
            return .view(view)
            
        #else
            
            return .text("TODO: Quick Look for CALayer!")
            
        #endif
    }
}
