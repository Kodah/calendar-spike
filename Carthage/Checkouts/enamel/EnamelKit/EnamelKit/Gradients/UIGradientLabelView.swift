//
//  UIGradientLabel.swift
//  Playground
//
//  Created by Rankovic, Milos (Developer) on 23/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public class UIGradientLabelView: UIView, LabelLayoutType, CanLayout {
    
    public var gradient: CAGradientLayer { return layer as! CAGradientLayer }
    
    public var colors: [UIColor] {
        get { return gradient.uiColors }
        set { gradient.uiColors = newValue }
    }
    
    public var angle: CGAngle {
        get { return gradient.angle }
        set { gradient.angle = newValue }
    }
    
    public override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    public private(set) lazy var label: UILabel = {
        let $ = UILabel()
        self.gradient.mask = $.layer
        return $
    }()
    
    public override func layoutSubviews() {
        _ = label.layout(in: bounds)
    }

    public var attributedText: NSAttributedString? {
        get { return label.attributedText }
        set { label.attributedText = newValue }
    }

    public func layout(in rect: CGRect) -> Self {
        frame = rect
        _ = label.layout(in: bounds)
        return self
    }
}
