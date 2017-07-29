//
//  UIPaddedGradientButton.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 12/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

open class UIPaddedGradientButton: UIGradientButton {
    
    open var padding: CGOffsets = 5 {
        didSet { setNeedsLayout() }
    }
    
    open override func layoutSubviews() {
        titleLabel?.frame = bounds - padding
        super.layoutSubviews()
    }
    
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let titleLabel = titleLabel else {
            return .zero + padding
        }
        return titleLabel.sizeThatFits(size - padding) + padding
    }
    
    open override func sizeToFit() {
        frame.size = intrinsicContentSize
    }
}
