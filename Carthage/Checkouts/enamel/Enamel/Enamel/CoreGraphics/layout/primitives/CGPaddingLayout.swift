//
//  CGPaddingLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 09/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension CGLayout {
    
    public func padded(by padding: CGOff) -> CGPaddingLayout {
        return CGPaddingLayout(padding: padding, child: self)
    }
}

public struct CGPaddingLayout {
    
    public let child: CGLayout
    public let padding: CGOff
    
    public init(padding: CGOff, child: CGLayout) {
        self.padding = padding
        self.child = child
    }
}

extension CGPaddingLayout: CGLayout {
    
    public var childLayouts: [CGLayout] {
        return [child]
    }
    
    public func size(toFit size: CGSize) -> CGSize {
        return child.size(toFit: size - padding) + padding
    }
    
    public func arrange(in rect: CGRect) {
        child.arrange(in: rect - padding)
    }
}
