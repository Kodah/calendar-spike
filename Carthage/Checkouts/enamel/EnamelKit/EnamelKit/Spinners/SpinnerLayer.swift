//
//  SpinnerLayer.swift
//  EnamelKit
//
//  Created by Jung, Matthew (Associate Software Developer) on 21/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be removed in future release of EnamelKit and moved to sky-app-ios/Toolkit.")
public class SpinnerLayer: CAShapeLayer {
    
    public override var lineWidth: CGFloat {
        didSet {
            setNeedsLayout()
        }
    }
    
    override public func layoutSublayers() {
        let arc = CGArc(
            center: bounds.center,
            radius: frame.size.min / 2 - lineWidth / 2,
            fraction: 1,
            direction: .clockwise
        )
        path = arc.path
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
    
    private func commonInit() {
        fillColor = nil
        strokeColor = .white
        lineCap = kCALineCapRound
        lineWidth = 3
    }
    
    private func strokeEndAnimation(fromValue: CGFloat = 0, toValue:CGFloat = 1, repeatCount: Float = .infinity) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = repeatCount
        group.animations = [animation]
        
        return group
    }
    
    private func strokeStartAnimation(fromValue: CGFloat = 0, toValue:CGFloat = 1, repeatCount: Float = .infinity) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = repeatCount
        group.animations = [animation]
        
        return group
    }
    
    private var rotationAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.keyTimes = [0,0.25,0.5,0.75,1]
        
        let fullCircle = 2*π
        
        let fractions: [CGFloat] = [0, 0.2, 0.5, 0.8, 1.0]
        
        animation.values = fractions.map({ $0 * fullCircle })
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = .infinity
        
        return animation
    }()
    
    public func stopAnimation() {
        removeAnimation(forKey: "strokeStart")
        removeAnimation(forKey: "strokeEnd")
        removeAnimation(forKey: "rotation")
    }
    
    public func startAnimation() {
        add(strokeStartAnimation(), forKey: "strokeStart")
        add(strokeEndAnimation(), forKey: "strokeEnd")
        add(rotationAnimation, forKey: "rotation")
    }
}

