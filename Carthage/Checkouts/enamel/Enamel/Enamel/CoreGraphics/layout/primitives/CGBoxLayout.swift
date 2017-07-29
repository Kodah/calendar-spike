//
//  CGBoxLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension CGLayout {
    
    public func arranged(_ alignment: CGRect.Alignment) -> CGBoxLayout {
        return CGBoxLayout(self, aligned: alignment)
    }
}

public struct CGBoxLayout {
    
    public let child: CGLayout
    public let alignment: CGRect.Alignment
    
    public init(_ child: CGLayout, aligned alignment: CGRect.Alignment) {
        self.child = child
        self.alignment = alignment
    }
}

extension CGBoxLayout: CGLayout {
    
    public var childLayouts: [CGLayout] {
        return [child]
    }
    
    public func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    public func arrange(in rect: CGRect) {
        let size = child.size(toFit: rect.size)
        let frame = size.rect(aligned: alignment, inside: rect)
        child.arrange(in: frame)
    }
}
