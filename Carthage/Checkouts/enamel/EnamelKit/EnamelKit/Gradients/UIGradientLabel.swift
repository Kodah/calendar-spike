//
//  UIGradientLabel.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 06/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

open class UIGradientLabel: UILabel {
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            gradientMask.layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    public var borderRadius: CGFloat = 0 {
        didSet {
            gradientMask.layer.cornerRadius = borderRadius
            setNeedsDisplay()
        }
    }
    
    public private(set) lazy var gradient: CAGradientLayer = {
        let o = CAGradientLayer()
        o.zPosition = 1
        o.colors = [CGColor.skyBlue, CGColor.gold]
        o.angle = 0.degrees
        o.mask = self.gradientMask.layer
        return o
    }()
    
    open override func layoutSubviews() {
        
        if gradient.superlayer !== self {
            layer.addSublayer(gradient)
        }
        super.layoutSubviews()
        
        gradientMask.copyLabelSpecificProperties(from: self)
        gradient.frame = layer.bounds
        gradientMask.frame = gradient.bounds
        
        gradientMask.textColor = .black
        textColor = .clear
    }
    
    private let gradientMask = UILabel()
}
