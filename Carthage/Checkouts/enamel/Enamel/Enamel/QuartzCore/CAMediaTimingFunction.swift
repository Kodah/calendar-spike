//
//  CAMediaTimingFunction.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CAMediaTimingFunction {
    
    public static var linear: CAMediaTimingFunction { return CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear) }
    public static var easeIn: CAMediaTimingFunction { return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn) }
    public static var easeOut: CAMediaTimingFunction { return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) }
    public static var easeInEaseOut: CAMediaTimingFunction { return CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut) }
    public static var Default: CAMediaTimingFunction { return CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault) }
}

