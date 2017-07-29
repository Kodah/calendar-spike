//
//  CGJustifiedLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension Sequence where Iterator.Element: CGLayout {
    
    public func justified(_ alignment: CGRect.Alignment) -> CGJustifiedLayout {
        return CGJustifiedLayout(
            aligning: alignment,
            children: array
        )
    }
}

public struct CGJustifiedLayout {
    
    public let childLayouts: [CGLayout]
    public let alignment: CGRect.Alignment
    
    public init(aligning: CGRect.Alignment, children: [CGLayout]) {
        self.alignment = aligning
        self.childLayouts = children
    }
    
    public init(aligning: CGRect.Alignment = .bottom(.left), children: CGLayout...) {
        self.init(aligning: aligning, children: children)
    }
}

extension CGJustifiedLayout: CGLayout {
    
    public func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    public func arrange(in rect: CGRect) {
        let group = sizes(toFit: rect.size).rects(
            justified: alignment,
            toFit: rect.size.along(alignment.layoutAxis),
            anchor: alignment.flipped.namedPoint,
            position: rect.point(named: alignment.flipped.namedPoint)
        )
        zip(childLayouts, group).forEach{ $0.arrange(in: $1) }
    }
    
    private func sizes(toFit size: CGSize) -> [CGSize] {
        return childLayouts.map{ $0.size(toFit: size) }
    }
}

extension CGJustifiedLayout: CGLayoutAlongAxis {
    
    public var layoutAxis: CGLayoutAxis {
        return alignment.layoutAxis
    }
}
