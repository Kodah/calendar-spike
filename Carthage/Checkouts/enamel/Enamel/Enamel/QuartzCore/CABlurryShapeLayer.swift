//
//  CABlurryShapeLayer.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 16/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import QuartzCore

open class CABlurryShapeLayer: CAShapeLayer {
    
    // compositingFilter = CIFilter(name: "CIAdditionCompositing") // TODO: Not supported yet on iOS
    
    open override var path: CGPath? {
        get { return shadowPath }
        set { shadowPath = newValue; setNeedsDisplay() }
    }
    
    public var blurRadius: CGFloat {
        get { return shadowRadius }
        set { shadowRadius = newValue; setNeedsDisplay() }
    }
    
    public var color: CGColor? {
        get { return shadowColor }
        set { shadowColor = newValue; setNeedsDisplay() }
    }
    
    private func commonInit() {
        shadowOpacity = 1
        shadowOffset = .zero
        strokeColor = nil
        fillColor = nil
    }
    
    public override init() {
        super.init()
        commonInit()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
        // our investigations suggest that `self` is
        // fully copied from `layer` at this point
        // and no further parameter setting is needed.
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
