//
//  CGAspectFittingLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 12/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//


public extension CGLayout {
    
    public func aspectFitting(
        size: CGSize,
        aligned alignment: CGRect.Alignment = .center)
        -> CGAspectFittingLayout
    {
        return CGAspectFittingLayout(
            size: size,
            aligned: alignment,
            child: self
        )
    }
    
    public func aspectFitting(
        square side: CGFloat,
        aligned alignment: CGRect.Alignment = .center)
        -> CGAspectFittingLayout
    {
        return CGAspectFittingLayout(
            size: CGSize(square: side),
            aligned: alignment,
            child: self
        )
    }
    
    public func aspectFitting(
        width: CGFloat,
        height: CGFloat,
        aligned alignment: CGRect.Alignment = .center)
        -> CGAspectFittingLayout
    {
        return CGAspectFittingLayout(
            size: CGSize(width: width, height: height),
            aligned: alignment,
            child: self
        )
    }
}

public struct CGAspectFittingLayout {
    
    public let size: CGSize
    public let alignment: CGRect.Alignment
    
    public let child: CGLayout
    
    public init(
        size: CGSize,
        aligned alignment: CGRect.Alignment = .center,
        child: CGLayout)
    {
        self.size = size
        self.alignment = alignment
        self.child = child
    }
}

extension CGAspectFittingLayout: CGLayout {
    
    public var childLayouts: [CGLayout] {
        return [child]
    }
    
    public func size(toFit _: CGSize) -> CGSize {
        return child.size(toFit: size)
    }
    
    public func arrange(in rect: CGRect) {
        let bounds = size(toFit: rect.size).rect(aligned: alignment, inside: rect)
        child.arrange(in: bounds)
    }
}
