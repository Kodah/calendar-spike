//
//  LabeledCircularIndicator.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 21/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

/**
 - note: Everything to do with Circular indicators is overdue of refactoring.
 For the momment, minimal work was done to switch this to CGLayout protocol.
 Future work will link animations and layout states as well as do away with
 so many ad hoc layout decisions...
 */

@available(*, deprecated, message: "Will be removed in future release of EnamelKit.")
open class LabeledCircularIndicator: CircularIndicator {
    
    public var title: NSAttributedString? {
        get { return titleLabel.attributedText }
        set { titleLabel.attributedText = newValue }
    }
    
    public var subtitle: NSAttributedString? {
        get { return subtitleLabel.attributedText }
        set { subtitleLabel.attributedText = newValue }
    }
    
    public override var fraction: CGFloat {
        didSet {
            if let animation = indicatorLayer.circleAnimation {
                titleLabel.layer.add(animation, forKey: nil)
                subtitleLabel.layer.add(animation, forKey: nil)
            }
            setNeedsLayout()
        }
    }
    
    public override var colors: [UIColor] {
        get {
            return super.colors
        }
        set {
            titleLabel.gradient.uiColors = newValue
            super.colors = newValue
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let r = circle.radius
        if (subtitle?.string ?? "").isEmpty {
            let bounds = circle.inscribedSquare.expandedBy(dx: r * 0.05, dy: r * -0.5)
            titleLabel.fitting(.center).arrange(in: bounds)
        } else {
            let bounds = circle.inscribedSquare.expandedBy(dx: r * 0.05, dy: r * -0.25)
            titleAndSubtitleLayout.arrange(in: bounds)
        }
    }
    
    public func titleColors(with colors: [UIColor]) {
        titleLabel.gradient.uiColors = colors
    }
    
    public func hideTitles() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.titleLabel.alpha = 0
                self.subtitleLabel.alpha = 0},
            completion: nil
        )
    }
    
    public func showTitles() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.titleLabel.alpha = 1
                self.subtitleLabel.alpha = 1},
            completion: nil
        )
    }
    
    public lazy var titleLabel: UIGradientLabel = {
        let o = UIGradientLabel(frame: .unit)
        o.gradient.colors = [CGColor.gold, CGColor.red]
        o.gradient.angle = 180.degrees
        self.addSubview(o)
        return o
    }()
    
    public lazy var subtitleLabel: UIGradientLabel = {
        let o = UIGradientLabel(frame: .unit)
        o.gradient.colors = [0.75, 0.5].map{ CGColor.with(white: $0, alpha: 1) }
        o.gradient.angle = 90.degrees
        self.addSubview(o)
        return o
    }()
    
    private var titleAndSubtitleLayout: CGLayout {
        return CGDivideLayout(
            atDistance: (circle.inscribedSquare.height * 0.65),
            from: .top,
            spacing: (circle.radius * -0.05),
            slice: titleLabel.fitting(.bottom(.center)),
            remainder: subtitleLabel.fitting(.top(.center))
        )
    }
}
