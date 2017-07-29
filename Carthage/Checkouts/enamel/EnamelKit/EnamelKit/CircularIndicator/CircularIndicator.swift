//
//  CircularIndicator.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be moved to MySky.Toolkit in future release of EnamelKit.")
open class CircularIndicator: UIView {
    
    public var colors: [UIColor] {
        get { return indicatorLayer.gradientLayer.uiColors }
        set { indicatorLayer.gradientLayer.uiColors = newValue }
    }
    
    public var angle: CGAngle {
        get { return indicatorLayer.gradientLayer.angle }
        set { indicatorLayer.gradientLayer.angle = newValue }
    }

    public var fraction: CGFloat {
        get { return indicatorLayer.fraction }
        set { indicatorLayer.fraction = newValue }
    }
    
    public var arc: CGArc { return indicatorLayer.arc }
    public var circle: CGCircle { return indicatorLayer.circle }
    
    open override func layoutSubviews() {
        indicatorLayer.frame = layer.bounds
    }
    
    public private(set) lazy var indicatorLayer: CircularIndicatorLayer = {
        let o = CircularIndicatorLayer()
        self.layer.addSublayer(o)
        return o
    }()
}

