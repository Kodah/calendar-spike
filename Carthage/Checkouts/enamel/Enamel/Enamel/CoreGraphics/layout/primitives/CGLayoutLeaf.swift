//
//  CGLayoutLeaf.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 15/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

open class CGLayoutLeaf {
    
    open var frame: CGRect = .zero
    
    public init() {}
}

extension CGLayoutLeaf: CGLayout {
    
    open var childLayouts: [CGLayout] {
        return []
    }
    
    open func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    open func arrange(in rect: CGRect) {
        frame = rect
    }
}

extension CGLayoutLeaf: SVG {
    
    open func add(to context: SVGContext) {
        context.rectangle(frame)
    }
}
