//
//  UIView+CGLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import UIKit

extension UIView: CGLayout {
    
    open var childLayouts: [CGLayout] {
        return []
    }
    
    open func size(toFit size: CGSize) -> CGSize {
        return sizeThatFits(size)
    }
    
    open func arrange(in rect: CGRect) {
        frame = rect
    }
}
