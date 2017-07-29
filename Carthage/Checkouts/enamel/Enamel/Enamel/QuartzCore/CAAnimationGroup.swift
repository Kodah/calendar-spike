//
//  CAAnimationGroup.swift
//  Widget
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import QuartzCore

public extension CAAnimationGroup {
    
    public convenience init(_ animations: CAAnimation...) {
        self.init(animations)
    }
    
    public convenience init(_ animations: [CAAnimation]) {
        self.init()
        self.animations = animations
    }
}
