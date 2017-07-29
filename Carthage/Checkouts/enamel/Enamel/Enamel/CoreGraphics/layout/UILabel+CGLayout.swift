//
//  UILabel+CGLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import UIKit

public extension UILabel {
    
    public func fitting(_ alignment: CGRect.Alignment, padding: CGOff = .zero) -> FittingLayout {
        return FittingLayout(label: self, alignment: alignment, padding: padding)
    }
}

// MARK:- FittingLayout
public extension UILabel {
    
    public struct FittingLayout {
        
        public var label: UILabel
        public var alignment: CGRect.Alignment
        public var padding: CGOff
        
        public init(
            label: UILabel,
            alignment: CGRect.Alignment,
            padding: CGOff = .zero)
        {
            self.label = label
            self.alignment = alignment
            self.padding = padding
        }
    }
}

extension UILabel.FittingLayout: CGLayout {
    
    public var childLayouts: [CGLayout] {
        return [label]
    }
    
    public func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    public func arrange(in rect: CGRect) {
        let rect = rect - padding
        guard let txt = label.attributedText else {
            label.frame = CGSize.zero.rect(
                aligned: alignment,
                inside: rect
            )
            return
        }
        label.attributedText = txt.sized(toFit: rect.size)
        label.frame = label.sizeThatFits(rect.size).rect(
            aligned: alignment,
            inside: rect
        )
    }
}
