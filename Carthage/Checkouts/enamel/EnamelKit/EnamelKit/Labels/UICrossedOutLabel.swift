//
//  UICrossedOutLabel.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 06/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public class UICrossedOutLabel: UILabel {
    
    // TODO: at different angles!
    
    public var fraction: CGFloat = 0.9 {
        didSet { fraction = (0...1).clamp(fraction) }
    }
    
    public var startFraction: CGFloat {
        return (0...1).clamp((1 - fraction) / 2)
    }
    
    public var endFraction: CGFloat {
        return 1 - startFraction
    }
    
    public private(set) lazy var lineLayer: CAShapeLayer = {
        let o = CAShapeLayer()
        o.fillColor = nil
        o.lineWidth = 1
        return o
    }()
    
    public lazy var animation: CABasicAnimation = CABasicAnimation(
        key: "strokeEnd",
        from: 0,
        to: 1,
        duration: 1
    )
    
    public func animate() {
        lineLayer.strokeEnd = 0
        
        async(after: 1.second) { [weak self] in
            guard let this = self else { return }
            this.lineLayer.strokeEnd = 1
            this.lineLayer.add(
                this.animation,
                forKey: this.animation.keyPath
            )
        }
    }
    
    public override func layoutSubviews() {
        lineLayer.removeFromSuperlayer()
        super.layoutSubviews()
        layer.addSublayer(lineLayer)
        
        let bl = bounds.bottomLeft
        let tr = bounds.topRight
        
        let angle = bl.angle(to: tr)
        let distance = bl.distance(to: tr)
        
        let start = bl.offsetBy(angle: angle, distance: distance * startFraction)
        let end = bl.offsetBy(angle: angle, distance: distance * endFraction)
        
        lineLayer.path = CGLine(start: start, end: end).path
        lineLayer.strokeColor = textColor.cgColor
    }
}
