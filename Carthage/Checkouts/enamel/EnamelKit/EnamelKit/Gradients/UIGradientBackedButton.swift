//
//  UIGradientBackedButton.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 06/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

open class UIGradientBackedButton: UIButton {
    
    public private(set) lazy var gradient: CAGradientLayer = {
        let o = CAGradientLayer()
        o.colors = [CGColor.skyBlue, CGColor.gold]
        o.angle = 0.degrees
        return o
    }()
    
    open override func layoutSubviews() {
        if gradient.superlayer != layer {
            layer.addSublayer(gradient)
        }
        gradient.zPosition = -1
        gradient.frame = layer.bounds
        super.layoutSubviews()
    }
}
