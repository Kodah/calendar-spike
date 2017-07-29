//
//  CALayer+CGLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension CALayer: CGLayout {
    
    open var childLayouts: [CGLayout] {
        return []
    }
    
    open func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    open func arrange(in rect: CGRect) {
        bounds = rect
    }
}
