//
//  CGStackLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension Sequence where Iterator.Element: CGLayout {
    
    public func stacked(aligning alignment: CGRect.Alignment, spacing: CGFloat = .zero) -> CGStackLayout {
        return CGStackLayout(
            spacing: spacing,
            aligning: alignment,
            children: array
        )
    }
}

public struct CGStackLayout {
    
    public let spacing: CGFloat
    public let alignment: CGRect.Alignment
    public let childLayouts: [CGLayout]

    public init(
        spacing: CGFloat = .zero,
        aligning alignment: CGRect.Alignment,
        children: [CGLayout])
    {
        self.spacing = spacing
        self.alignment = alignment
        self.childLayouts = children
    }
    
    public init(
        spacing: CGFloat = .zero,
        aligning: CGRect.Alignment = .bottom(.left),
        children: CGLayout...)
    {
        self.init(
            spacing: spacing,
            aligning: aligning,
            children: children
        )
    }
}

extension CGStackLayout: CGLayout {
    
    public func size(toFit size: CGSize) -> CGSize {
        let group = childLayouts
            .map{ $0.size(toFit: size) }
            .rects(aligned: alignment, spacing: spacing)
        
        if alignment.isVertical {
            return size.with(height: group.size.height)
        } else {
            return size.with(width: group.size.width)
        }
    }
    
    public func arrange(in rect: CGRect) {
        let sizes = childLayouts.map{ $0.size(toFit: rect.size) }
        let frames = sizes.rects(
            aligned: alignment,
            anchor: alignment.flipped.namedPoint,
            position: rect.point(named: alignment.flipped.namedPoint),
            spacing: spacing
        )
        zip(childLayouts, frames).forEach{ $0.arrange(in: $1) }
    }
}

extension CGStackLayout: CGLayoutAlongAxis {
    
    public var layoutAxis: CGLayoutAxis {
        return alignment.layoutAxis
    }
}
