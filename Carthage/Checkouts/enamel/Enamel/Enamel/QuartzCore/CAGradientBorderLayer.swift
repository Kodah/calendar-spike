//
//  CAGradientBorderLayer.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public class CAGradientBorderLayer: CAGradientLayer {
    
    public override var borderWidth: CGFloat {
        get { return super.borderWidth }
        set {
            super.borderWidth = newValue
            maskLayer.borderWidth = newValue
        }
    }
    
    public override var cornerRadius: CGFloat {
        get { return super.cornerRadius }
        set {
            super.cornerRadius = newValue
            maskLayer.cornerRadius = newValue
        }
    }
    
    public override func layoutSublayers() {
        maskLayer.frame = bounds
    }
    
    private lazy var maskLayer: CALayer = {
        let o = CALayer()
        o.borderWidth = 0.5
        self.mask = o
        self.borderColor = .clear
        return o
    }()
}
