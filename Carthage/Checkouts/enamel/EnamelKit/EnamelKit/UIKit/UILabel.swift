//
//  UILabel.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 18/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

extension UILabel {
    
    public convenience init(_ text: NSAttributedString) {
        self.init(frame: .unit)
        attributedText = text
    }
}

extension UILabel {
    
    public var wrappable: UILabel {
        allowWordWrapping()
        return self
    }
    
    open func allowWordWrapping() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
}

extension UILabel {
    
    // supprt for gradient labels and buttons:
    open func copyLabelSpecificProperties(from other: UILabel) {
        adjustsFontSizeToFitWidth = other.adjustsFontSizeToFitWidth
        allowsDefaultTighteningForTruncation = other.allowsDefaultTighteningForTruncation
        attributedText = other.attributedText
        baselineAdjustment = other.baselineAdjustment
        isEnabled = other.isEnabled
        lineBreakMode = other.lineBreakMode
        minimumScaleFactor = other.minimumScaleFactor
        numberOfLines = other.numberOfLines
        preferredMaxLayoutWidth = other.preferredMaxLayoutWidth
        textAlignment = other.textAlignment
    }
}

extension UILabel {
    
    open func superscriptCents(currencySymbol symbol: String? = nil, fontName: String? = nil) {
        attributedText = attributedText?.withSuperscriptCents(
            currencySymbol: symbol,
            fontName: fontName
        )
    }
}
