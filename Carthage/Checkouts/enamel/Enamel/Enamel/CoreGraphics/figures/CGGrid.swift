//
//  CGGrid.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 22/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct CGGrid {
    
    public var frame: CGRect
    public var rows: Int
    public var cols: Int
    public var padding: CGFloat
    public var spacing: CGFloat
    
    public init(
        frame: CGRect,
        rows: Int = 1,
        cols: Int = 1,
        padding: CGFloat = 0,
        spacing: CGFloat = 0)
    {
        self.frame = frame
        self.rows = rows
        self.cols = cols
        self.padding = padding
        self.spacing = spacing
    }
    
    public init(
        tile tileSize: CGSize,
        origin: CGPoint = .zero,
        rows: Int = 1,
        cols: Int = 1,
        padding: CGFloat = 0,
        spacing: CGFloat = 0)
    {
        let count = (cols.cg, rows.cg)
        let totalSpacing = (count - 1) * spacing
        let size = tileSize * count + totalSpacing + (padding * 2)
        self.init(
            frame: CGRect(origin: origin, size: size),
            rows: rows,
            cols: cols,
            padding: padding,
            spacing: spacing
        )
    }
}

public extension CGGrid {
    
    public init(
        aligned alignment: CGRect.Alignment,
        in bounds: CGRect,
        rows: Int = 1,
        cols: Int = 1,
        cellAspectRatio a: CGFloat,
        spacingAsFractionOfCellWidth s: CGFloat = 0)
    {
        guard a > 0 else {
            self.init(frame: .zero, rows: 0, cols: 0)
            return
        }
        // fit horizontally:
        var cellWidth = CGGrid.cellWidthWhen(a: 1, b: bounds.width, c: cols.cg, s: s)
        var size = CGGrid.sizeWhen(
            cellSize: CGSize(width: cellWidth, height: cellWidth / a),
            rows: rows,
            cols: cols,
            spacing: cellWidth * s
        )
        if size.height > bounds.height {
            // else, fit vertically:
            cellWidth = CGGrid.cellWidthWhen(a: a, b: bounds.height, c: rows.cg, s: s)
            size = CGGrid.sizeWhen(
                cellSize: CGSize(width: cellWidth, height: cellWidth / a),
                rows: rows,
                cols: cols,
                spacing: cellWidth * s
            )
        }
        self.init(
            frame: size.rect(aligned: alignment, inside: bounds),
            rows: rows,
            cols: cols,
            spacing: cellWidth * s
        )
    }
    
    private static func cellWidthWhen(a: CGFloat, b: CGFloat, c: CGFloat, s: CGFloat) -> CGFloat {
        guard a > 0, b > 0, c > 0 else { return 0 }
        let d = c * s + c - s
        guard d > 0 else { return 0 }
        return a * b / d
    }
}

public extension CGGrid {
    
    public static let zero = CGGrid(frame: .zero, rows: 0, cols: 0)
    public static let unit = CGGrid(frame: .unit)
    
    public static func sizeWhen(cellSize: CGSize, rows: Int, cols: Int, padding: CGFloat = 0, spacing: CGFloat = 0) -> CGSize {
        let (c, r) = (cols.cg, rows.cg)
        let spacing = ((c - 1) * spacing, (r - 1) * spacing)
        let padding = padding * 2
        return cellSize * (cols.cg, rows.cg) + spacing + padding
    }
}

public extension CGGrid {
    
    public var cellSize: CGSize {
        return CGSize(
            width: (frame.width - padding * 2 - spacing * (cols - 1).cg) / cols.cg,
            height: (frame.height - padding * 2 - spacing * (rows - 1).cg) / rows.cg
        )
    }
    
    public func cellAt(index: Int) -> CGRect? {
        return cellAt(
            row: index / self.cols,
            col: index % self.cols
        )
    }
    
    public func cellAt(row: Int, col: Int) -> CGRect? {
        guard (0..<rows) ~= row && (0..<cols) ~= col else {
            return nil
        }
        let (x, y, cellSize) = (frame.origin.x, frame.origin.y, self.cellSize)
        return CGRect(
            x: x + padding + col.cg * (cellSize.width + spacing),
            y: y + padding + row.cg * (cellSize.height + spacing),
            width: cellSize.width,
            height: cellSize.height
        )
    }
}

extension CGGrid: RandomAccessCollection {
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return rows * cols }
    
    public func index(after i: Int) -> Int { return i + 1 }
    public func index(before i: Int) -> Int { return i - 1 }
    
    public subscript(index: Int) -> CGRect {
        let o = cellAt(index: index)
        precondition(o != nil, "Index out of range (\(index)).")
        return o!
    }
}

extension CGGrid: SVG {
    public func add(to context: SVGContext) {
        context.rectangle(frame)
        for cell in self {
            context.rectangle(cell)
        }
    }
}
