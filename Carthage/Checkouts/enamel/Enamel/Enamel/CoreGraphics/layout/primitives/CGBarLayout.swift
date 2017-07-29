//
//  CGBarLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension CGLayout {
    
    public func aligned(_ alignment: CGRect.Alignment) -> CGBarLayout {
        return CGBarLayout(self, alignment)
    }
}

public struct CGBarLayout {
    
    public let child: CGLayout
    public let alignment: CGRect.Alignment
    
    public init(_ child: CGLayout, _ alignment: CGRect.Alignment) {
        self.alignment = alignment
        self.child = child
    }
}

extension CGBarLayout: CGLayout {
    
    public var childLayouts: [CGLayout] { return [child] }
    
    public func size(toFit size: CGSize) -> CGSize {
        if alignment.isVertical {
            return size.with(width: child.size(toFit: size).width)
        } else {
            return size.with(height: child.size(toFit: size).height)
        }
    }
    
    public func arrange(in rect: CGRect) {
        let frame = child.size(toFit: rect.size).rect(
            aligned: alignment,
            inside: rect
        )
        child.arrange(in: frame)
    }
}
