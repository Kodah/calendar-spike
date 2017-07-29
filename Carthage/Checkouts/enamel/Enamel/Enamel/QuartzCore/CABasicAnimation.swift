//
//  CABasicAnimation.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CABasicAnimation {
    
    public convenience init(
        key: String,
        from startValue: Any,
        to endValue: Any,
        duration: CFTimeInterval,
        timingFunction: CAMediaTimingFunction = .Default)
    {
        self.init()
        self.keyPath = key
        self.fromValue = startValue
        self.toValue = endValue
        self.duration = duration
        self.timingFunction = timingFunction
    }
}
