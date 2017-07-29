//
//  CAGradientLayer.swift
//  SwiftSky
//
//  Created by milos on 07/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CAGradientLayer {
    
    public var angle: CGAngle {
        get {
            return startPoint.angle(to: endPoint)
        }
        set(θ) {
            let d = abs(θ.sin) + abs(θ.cos) // bounds.width of a rotated unit square
            endPoint = CGSize.unit.center.offsetBy(angle: θ, distance: d / 2)
            startPoint = -endPoint + 1
        }
    }
}
