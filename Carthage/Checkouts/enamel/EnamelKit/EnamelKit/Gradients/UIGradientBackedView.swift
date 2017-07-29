//
//  UIGradientBackedView.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 11/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

open class UIGradientBackedView: UIView {
    
    open override class var layerClass: AnyClass {
        return Layer.self
    }
    
    public var contentLayer: Layer { return layer as! Layer }
    
    public var gradient: CAGradientLayer { return contentLayer.gradient }
    
    public var locations: [CGFloat] {
        get { return gradient.locations?.filter(CGFloat.self) ?? [] }
        set { gradient.locations = newValue.filter(NSNumber.self) }
    }
    
    public var colors: [UIColor] {
        get { return gradient.uiColors }
        set { gradient.uiColors = newValue }
    }
    
    public var angle: CGAngle {
        get { return gradient.angle }
        set { gradient.angle = newValue }
    }
    
    public class Layer: CALayer {
        
        public override func layoutSublayers() {
            gradient.frame = bounds
            super.layoutSublayers()
        }
        
        public private(set) lazy var gradient: CAGradientLayer = {
            let $ = CAGradientLayer()
            $.zPosition = -1
            self.addSublayer($)
            return $
        }()
    }
    
    //FIXME: Remove the need of generating an image
    public var image: UIImage {
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
