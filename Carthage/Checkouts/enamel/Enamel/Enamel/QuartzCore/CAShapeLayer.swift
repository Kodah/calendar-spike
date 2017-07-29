//
//  CAShapeLayer.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 14/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CAShapeLayer {

    public convenience init(path: CGPath, style: [String:Any]? = nil) {
        self.init()
        self.path = path
        if let style = style {
            self.style = style
        }
    }
}

public extension CGLineCap {
    
    public var ca: String {
        switch self {
        case .butt: return kCALineCapButt
        case .round: return kCALineCapRound
        case .square: return kCALineCapSquare
        }
    }
}

public extension CAShapeLayer { // shadow
    
    public var shadowBounds: CGRect {
        guard let path = shadowPath ?? path else {
            return .zero
        }
        return path.boundingBoxOfPath.insetBy(margin: -shadowRadius).integral
    }

    public func layoutStandupShadow(widthFraction: CGFloat = 0.9, radiusLineRatio: CGFloat = 0.8) {
        guard let path = path, shadowOpacity > 0 else {
            return
        }
        shadowOffset = .zero
        shadowRadius = lineWidth * radiusLineRatio
        let bounds = path.boundingBoxOfPath
        guard bounds.area > 0 && lineWidth >= 1 else {
            shadowPath = nil
            return
        }
        let elipse = CGEllipse(
            center: bounds.midXmaxY.offsetBy(dy: shadowRadius),
            xRadius: bounds.width * widthFraction * 0.5,
            yRadius: shadowRadius
        )
        shadowPath = elipse.path
    }
}
