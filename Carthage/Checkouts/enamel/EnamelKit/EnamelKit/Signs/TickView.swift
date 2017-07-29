//
//  TickView.swift
//  EnamelKit
//
//  Created by Agno, Edgardo (Developer) on 11/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be removed in future release of EnamelKit and moved to sky-app-ios/Toolkit.")
public class TickView: UIView {

    public var on: Bool = false {
        didSet {
            if on {
                guard animated else {
                    tickLayer.removeFromSuperlayer()
                    tickLayer = createTickLayer()
                    layoutSubviews()
                    return
                }
                tickLayer.removeAllAnimations()
                tickLayer.add(tickAnimation, forKey: "strokeEnd")
            } else {
                guard animated else {
                    tickLayer.removeFromSuperlayer()
                    return
                }
                tickLayer.removeAllAnimations()
                tickLayer.add(untickAnimation, forKey: "strokeStart")
                tickLayer.add(fadeAnimation, forKey: "opacity")
            }
        }
    }
    
    public func setOn(_ on: Bool, animated: Bool) {
        self.animated = animated
        self.on = on
    }
    
    private var animated: Bool = false
    
    @IBInspectable public var color: UIColor = UIColor(rgb: 0x20A729) {
        didSet {
            tickLayer.strokeColor = color.cgColor
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat {
        didSet {
            tickLayer.lineWidth = lineWidth
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.lineWidth = 5 // FIXME: encode/decode lineWidth
        super.init(coder: aDecoder)
    }
    
    public init(frame: CGRect, lineWidth: CGFloat = 5) {
        self.lineWidth = lineWidth
        super.init(frame: frame)
    }
    
    public override func layoutSubviews() {
        tickLayer.path = CGTick(rect: bounds.insetBy(margin: lineWidth / 2)).path
    }
    
    // MARK:- Layers
    
    public private(set) lazy var tickLayer: CAShapeLayer = self.createTickLayer()
    
    private func createTickLayer() -> CAShapeLayer {
        let $ = CAShapeLayer()
        $.lineJoin = kCALineJoinRound
        $.lineCap = kCALineCapRound
        $.lineWidth = self.lineWidth
        $.strokeColor = UIColor(rgb: 0x20A729).cgColor
        $.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer($)
        return $
    }
    
    // MARK:- Animation
    
    private static let duration = 0.6
    
    private var tickAnimation: CAAnimation = {
        let animation = CABasicAnimation(
            key: "strokeEnd",
            from: 0, to: 1,
            duration: duration,
            timingFunction: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    }()
    
    private var untickAnimation: CAAnimation = {
        let animation = CABasicAnimation(
            key: "strokeStart",
            from: 0, to: 1,
            duration: duration,
            timingFunction: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    }()
    
    private var fadeAnimation: CAAnimation = {
        let animation = CABasicAnimation(
            key: "opacity",
            from: 1, to: 0,
            duration: duration + 0.1,
            timingFunction: .easeInEaseOut)
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        return animation
    } ()
    
}

