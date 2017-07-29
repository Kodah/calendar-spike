//
//  CGFlowLayout.swift
//  Enamel
//
//  Created by Sugarev, Thomas (iOS Developer) on 03/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public struct CGFlowLayout {
    
    // TODO: lineHeight (mabye an enum witch cases: variable, unified, fixed)
    // TODO: lines: [[CGLayout]] or [CGLayout]
    // TODO: performance (e.g. calc all sizes upfront)
    
    public var childLayouts: [CGLayout]
    
    public let childSpacing: CGFloat
    public let childAlignment: CGRect.Alignment
    public let lineSpacing: CGFloat
    public let lineAlignment: CGRect.Alignment
    
    public init(
        childSpacing: CGFloat = 0,
        childAlignment: CGRect.Alignment = .right(.center),
        lineSpacing: CGFloat = 0,
        lineAlignment: CGRect.Alignment = .bottom(.left),
        children: [CGLayout])
    {
        self.childLayouts = children
        self.lineAlignment = lineAlignment
        self.childSpacing = childSpacing
        self.lineSpacing = lineSpacing
        self.childAlignment = childAlignment
    }
}

extension CGFlowLayout {
    
    public struct ChildSettings {
        public let spacing: CGFloat
        public let alignment: CGRect.Alignment
        public static func set(spacing: CGFloat = 0, alignment: CGRect.Alignment = .right(.center)) -> ChildSettings {
            return .init(spacing: spacing, alignment: alignment)
        }
    }
    
    public struct LineSettings {
        public let spacing: CGFloat
        public let alignment: CGRect.Alignment
        public static func set(spacing: CGFloat = 0, alignment: CGRect.Alignment = .bottom(.left)) -> LineSettings {
            return .init(spacing: spacing, alignment: alignment)
        }
    }
    
    public init(child: ChildSettings = .set(), line: LineSettings = .set(), children: [CGLayout]) {
        self.init(
            childSpacing: child.spacing,
            childAlignment: child.alignment,
            lineSpacing: line.spacing,
            lineAlignment: line.alignment,
            children: children
        )
    }
}

extension CGFlowLayout: CGLayout {
    
    public func size(toFit size: CGSize) -> CGSize {
        return measurableArrange(in: CGRect(center: .zero, size: size), shouldArrange: false)
    }
    
    public func arrange(in rect: CGRect) {
        measurableArrange(in: rect)
    }
    
    @discardableResult
    private func measurableArrange(in rect: CGRect, shouldArrange: Bool = true) -> CGSize {
        var rowWidth: CGFloat = 0
        var cols: [CGLayout] = []
        var row: [CGLayout] = []
        var rowSize: CGSize
        
        let limit = childAlignment.isVertical ? rect.height : rect.width
        
        for i in 0 ..< childLayouts.count {
            row.append(childLayouts[i])
            
            rowSize = CGStackLayout(
                spacing: childSpacing,
                aligning: childAlignment,
                children: row).size(toFit: rect.size)
            
            rowWidth = childAlignment.isVertical ? rowSize.height : rowSize.width
            
            if rowWidth > limit {
                cols.append( CGStackLayout(
                    spacing: childSpacing,
                    aligning: childAlignment,
                    children: row.dropLast().array).snugged
                )
                
                if let last = row.last {
                    row = [last]
                }
            }
            
            if i == childLayouts.count - 1 {
                cols.append( CGStackLayout(
                    spacing: childSpacing,
                    aligning: childAlignment,
                    children: row).snugged
                )
            }
        }
        
        
        let stack = CGStackLayout(
            spacing: lineSpacing,
            aligning: lineAlignment,
            children: cols)
        
        if shouldArrange {
            stack.arrange(in: rect)
        }
        
        return stack.size(toFit: rect.size)
    }
}
