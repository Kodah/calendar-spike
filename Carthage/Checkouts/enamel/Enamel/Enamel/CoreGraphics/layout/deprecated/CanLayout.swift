//
//  CanLayout.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 23/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public protocol CanLayout {
    @discardableResult func layout(in rect: CGRect) -> Self
}
