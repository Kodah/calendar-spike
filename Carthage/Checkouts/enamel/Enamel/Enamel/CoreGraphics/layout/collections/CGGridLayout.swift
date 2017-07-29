//
//  CGGridLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension Sequence where Iterator.Element: CGLayout {
    
    public func tiled(rows: Int, cols: Int, spacing: CGFloat = .zero) -> CGGridLayout {
        return CGGridLayout(
            rows: rows,
            cols: cols,
            spacing: spacing,
            children: array
        )
    }
}

public struct CGGridLayout {
    
    public var rows: Int
    public var cols: Int
    public var spacing: CGFloat
    public var childLayouts: [CGLayout]
    
    public init(
        rows: Int,
        cols: Int,
        spacing: CGFloat = 0,
        children: [CGLayout])
    {
        self.rows = rows
        self.cols = cols
        self.spacing = spacing
        self.childLayouts = children
    }
    
    public init(
        rows: Int,
        cols: Int,
        spacing: CGFloat = 0,
        children: CGLayout...)
    {
        self.init(rows: rows, cols: cols, spacing: spacing, children: children)
    }
}

extension CGGridLayout: CGLayout {
    
    public func grid(toFit frame: CGRect) -> CGGrid {
        return CGGrid(frame: frame, rows: rows, cols: cols, spacing: spacing)
    }
    
    public func size(toFit size: CGSize) -> CGSize {
        return grid(toFit: size.rect()).frame.size
    }
    
    public func arrange(in rect: CGRect) {
        let grid = self.grid(toFit: rect)
        zip(childLayouts, grid).forEach{ $0.arrange(in: $1) }
    }
}
