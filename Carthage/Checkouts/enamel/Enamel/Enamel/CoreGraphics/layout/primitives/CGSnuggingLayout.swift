//
//  CGSnuggingLayout.swift
//  EnamelKit
//
//  Created by Prescott, Ste on 17/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension CGLayout where Self: CGLayoutAlongAxis {
    
    public var snugged: CGSnuggingLayout {
        return CGSnuggingLayout(child: self)
    }
}

public struct CGSnuggingLayout: CGLayout {
    
    public let child: CGLayoutAlongAxis
    
    public var childLayouts: [CGLayout] { return [child] }
    
    public func size(toFit size: CGSize) -> CGSize {
        
        let sizes = child.childLayouts.map{ $0.size(toFit: size) }
        
        let maxChildExtent = sizes
            .map{ child.layoutAxis == .vertical ? $0.width : $0.height }
            .max() ?? 0
        
        let unconstrainedSize = child.size(toFit: size)
        
        switch child.layoutAxis
        {
        case .vertical:
            return unconstrainedSize.with(width: maxChildExtent)
            
        case .horizontal:
            return unconstrainedSize.with(height: maxChildExtent)
        }
    }
    
    public func arrange(in rect: CGRect) {
        child.arrange(in: rect)
    }
}
