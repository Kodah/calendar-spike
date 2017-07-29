//
//  NSShadow.swift
//  SwiftSkyUI
//
//  Created by milos on 20/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Enamel
import UIKit

public extension NSShadow {
    
    public convenience init(
        radius: CGFloat,
        color: UIColor = .black,
        alpha: CGFloat = 0.5,
        dx: CGFloat = 0,
        dy: CGFloat = 0)
    {
        self.init()
        shadowBlurRadius = radius
        shadowColor = color.withAlphaComponent(alpha)
        shadowOffset = CGSize(width: dx, height: dy)
    }
}

