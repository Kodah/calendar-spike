//
//  GridLayout.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 26/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public struct GridLayout<Cell: CanLayout>: CanLayout {
    
    public var rows: Int
    public var cols: Int
    public var padding: CGFloat
    public var spacing: CGFloat
    public var cells: [Cell]
    
    public init(rows: Int, cols: Int, padding: CGFloat = 0, spacing: CGFloat = 0, cells: Cell...) {
        self.init(rows: rows, cols: cols, padding: padding, spacing: spacing, cells: cells)
    }
    
    public init(rows: Int, cols: Int, padding: CGFloat = 0, spacing: CGFloat = 0, cells: [Cell]) {
        self.rows = rows
        self.cols = cols
        self.padding = padding
        self.spacing = spacing
        self.cells = cells
    }
    
    public func layout(in rect: CGRect) -> GridLayout {
        let grid = CGGrid(frame: rect, rows: rows, cols: cols, padding: padding, spacing: spacing)
        for (cell, frame) in zip(cells, grid) {
            cell.layout(in: frame)
        }
        return self
    }
}
