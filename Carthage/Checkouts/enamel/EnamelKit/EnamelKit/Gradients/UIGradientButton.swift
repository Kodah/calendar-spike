//
//  UIGradientButton.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 31/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@IBDesignable open class UIGradientButton: UIButton {
    
    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    open var gradient: CAGradientLayer { return layer as! CAGradientLayer }
    
    open var colors: [UIColor] {
        get { return gradient.uiColors }
        set { gradient.uiColors = newValue }
    }
    
    open var angle: CGAngle {
        get { return gradient.angle }
        set { gradient.angle = newValue }
    }
    
    @IBInspectable open var borderWidth: CGFloat {
        get { return gradientMask.layer.borderWidth }
        set { gradientMask.layer.borderWidth = newValue }
    }
    
    @IBInspectable open var cornerRadius: CGFloat {
        get { return gradientMask.layer.cornerRadius }
        set { gradientMask.layer.cornerRadius = newValue }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientMask.frame = bounds
        guard let title = titleLabel else {
            label.attributedText = nil
            label.frame = .zero
            return
        }
        label.copyLabelSpecificProperties(from: title)
        label.frame = title.frame
        label.textColor = .black
        title.textColor = .clear
    }
    
    open override func setTitle(_ title: String?, for state: UIControlState) {
        UIView.performWithoutAnimation { () -> Void in
            super.setTitle(title, for: state)
            self.layoutIfNeeded()
            self.setNeedsDisplay()
        }
    }

    open override func setAttributedTitle(_ title: NSAttributedString?, for state: UIControlState) {
        UIView.performWithoutAnimation {
            super.setAttributedTitle(title, for: state)
            self.layoutIfNeeded()
            self.setNeedsDisplay()
        }
    }

    // MARK:- private
    
    public private(set) lazy var gradientMask: UIView = {
        let $ = UIView()
        self.mask = $
        return $
    }()
    
    private lazy var label: UILabel = {
        let $ = UILabel()
        self.titleLabel?.textColor = .clear
        self.gradientMask.addSubview($)
        return $
    }()
}
