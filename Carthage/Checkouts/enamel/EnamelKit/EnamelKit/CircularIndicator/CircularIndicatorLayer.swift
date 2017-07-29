//
//  CircularIndicatorLayer.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 19/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be moved to MySky.Toolkit in future release of EnamelKit.")
public class CircularIndicatorLayer: CALayer {

    public var fraction: CGFloat = 0.0 { didSet { fractionDidChange() } }
    public var startFraction: CGFloat = -0.25 { didSet { layoutSublayers() } }

    public var arc: CGArc { return CGArc(circle: circle, startFraction: startFraction, fraction: fraction, direction: .clockwise) }
    public var circle: CGCircle { return square.insetBy(margin: padding).incircle() }

    public var padding: CGFloat { return (arcLineWidth / 2).ceil }
    public var square: CGRect { return CGRect(center: bounds.center, size: CGSize(square: bounds.size.min)) }

    // MARK:- Event handlers

    public override var bounds: CGRect { didSet { layoutSublayers() } }

     func fractionDidChange() {
        layoutSublayers()
        removeLoadingAnimation()
        circleAnimation.forSome{ self.circleLayer.add($0, forKey: nil) }
        strokeAnimation.forSome{ self.arcLayer.add($0, forKey: nil) }
    }

    // MARK:- Layout

    private var arcLineWidth: CGFloat { return bounds.size.min * arcLineWidthFraction }
    private var circleLineWidth: CGFloat { return bounds.size.min * circleLineWidthFraction }

    private let arcLineWidthFraction: CGFloat = 0.03
    private let circleLineWidthFraction: CGFloat = 0.022

    public func addLoadingAnimation() {
        fraction = 1
        arcLayer.add(strokeStartAnimation, forKey: "strokeStart")
        arcLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        arcLayer.add(rotationAnimation, forKey: "rotation")
    }

    public func removeLoadingAnimation() {
        arcLayer.removeAnimation(forKey: "strokeStart")
        arcLayer.removeAnimation(forKey: "strokeEnd")
        arcLayer.removeAnimation(forKey: "rotation")
    }

    public override func layoutSublayers() {
        circleLayer.frame = square
        gradientLayer.frame = square
        arcLayer.frame = gradientLayer.bounds

        arcLayer.lineWidth = arcLineWidth
        circleLayer.lineWidth = circleLineWidth

        circleLayer.path = circle.with(center: circleLayer.bounds.center).path
        circleLayer.layoutStandupShadow()

        arcLayer.path = arc.with(center: arcLayer.bounds.center).path
    }

    // MARK:- Animation

    public var strokeAnimation: CAAnimation? = CABasicAnimation(
        key: "strokeEnd",
        from: 0, to: 1,
        duration: 0.6,
        timingFunction: .easeIn
    )

    public var circleAnimation: CAAnimation? = CABasicAnimation(
        key: "opacity",
        from: 0, to: 1,
        duration: 0.6,
        timingFunction: .easeIn
    )

    public var strokeEndAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = .infinity
        group.animations = [animation]

        return group
    }()

    public var strokeStartAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.beginTime = 0.5
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 2.5
        group.repeatCount = .infinity
        group.animations = [animation]

        return group
    }()

    private var rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = 2 * π
        animation.duration = 4
        animation.repeatCount = .infinity
        return animation
    }()

    // MARK:- Layers

    public private(set) lazy var arcLayer: CAShapeLayer = {
        var $ = CAShapeLayer()
        $.fillColor = nil
        // defaults:
        $.strokeColor = .black
        $.lineCap = kCALineCapRound
        return $
    }()

    public private(set) lazy var gradientLayer: CAGradientLayer = {
        let $ = CAGradientLayer()
        $.mask = self.arcLayer
        $.zPosition = 2
        // defaults:
        $.colors = [CGColor.gold, CGColor.red]
        // add:
        self.addSublayer($)
        return $
    }()

    public private(set) lazy var circleLayer: CAShapeLayer = {
        let $ = CAShapeLayer()
        $.zPosition = 1
        $.fillColor = .white
        // defaults:
        $.strokeColor = .with(white: 0.9)
        $.shadowOpacity = 0.15
        // add:
        self.addSublayer($)
        return $
    }()
}

public class CACircleLayer: CAShapeLayer {

    public private(set) var circle: CGCircle = .unit {
        didSet {
            guard circle != oldValue else { return }
            path = circle.path
        }
    }

    public override func layoutSublayers() {
        circle = bounds.incircle()
    }
}

public class CAArcLayer: CAShapeLayer {

    public var startAngle: CGAngle {
        get { return arc.startAngle }
        set { arc.startAngle = newValue; needsDisplay() }
    }

    public var endAngle: CGAngle {
        get { return arc.endAngle }
        set { arc.endAngle = newValue; needsDisplay() }
    }

    public var angle: CGAngle {
        get { return arc.angle }
        set { arc.angle = newValue; needsDisplay() }
    }

    public private(set) var arc = CGArc(radius: 1, endAngle: 1.rotations) {
        didSet {
            guard arc != oldValue else { return }
            path = arc.path
        }
    }

    public override func layoutSublayers() {
        arc = arc.with(circle: bounds.incircle())
    }
}

public class CAGradientArcLayer: CAGradientLayer {

    public var arc: CGArc { return arcLayer.arc }

    public var paddingFraction: CGFloat = 0.2 {
        didSet {
            needsLayout()
        }
    }

    public var padding: CGFloat { return paddingFraction * bounds.size.min }

    public private(set) lazy var arcLayer: CAArcLayer = {
        let $ = CAArcLayer()
        self.mask = $
        return $
    }()
    
    public override func layoutSublayers() {
        arcLayer.layout(at: bounds.center, anchor: .center, size: bounds.size - padding)
    }
}
