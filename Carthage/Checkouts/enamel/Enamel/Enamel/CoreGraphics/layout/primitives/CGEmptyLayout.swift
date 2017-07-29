//
//  CGEmptyLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public struct CGEmptyLayout: CGLayout {
    public let childLayouts: [CGLayout] = []
    public func size(toFit size: CGSize) -> CGSize { return size }
    public func arrange(in rect: CGRect) {}
    public init() {}
}
