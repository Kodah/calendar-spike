//
//  CGLayoutAxis.swift
//  EnamelKit
//
//  Created by Prescott, Ste on 17/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public enum CGLayoutAxis {
    case vertical
    case horizontal
}

public protocol CGLayoutAlongAxis: CGLayout {
    var layoutAxis: CGLayoutAxis { get }
}

extension CGRectEdge {
    public var layoutAxis: CGLayoutAxis {
        return isVertical ? .vertical : .horizontal
    }
}

extension CGRect.Alignment {
    public var layoutAxis: CGLayoutAxis {
        return isVertical ? .vertical : .horizontal
    }
}

extension CGSize {
    public func along(_ axis: CGLayoutAxis) -> CGFloat {
        switch axis {
        case .vertical: return height
        case .horizontal: return width
        }
    }
}

extension CGOff {
    public func along(_ axis: CGLayoutAxis) -> CGFloat {
        switch axis {
        case .vertical: return vertical
        case .horizontal: return horizontal
        }
    }
}
