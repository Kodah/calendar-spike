//
//  CGArc+iOSTests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 24/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGArc_iOSTests: XCTestCase {

    func test_clockwise() {
        let arc = CGArc(radius: 5, angle: 30.degrees, direction: .clockwise)
        assert(arc.endAngle) ~= 30.degrees ± 0.01
    }
    
    func test_anticlockwise() {
        let arc = CGArc(radius: 5, angle: 30.degrees, direction: .counterClockwise)
        assert(arc.endAngle) ~= -30.degrees ± 0.01
    }
    
    func test_with_circle() {
        let arc = CGArc(radius: 5, angle: 30.degrees, direction: .clockwise)
        let updatedArc = arc.with(circle: CGCircle(center: CGPoint(x:1,y:2), radius: 10))
        
        assert(updatedArc.center) ~= CGPoint(x:1,y:2) ± 0.01
        assert(updatedArc.radius) ~= 10 ± 0.01
        assert(updatedArc.endAngle) ~= 30.degrees ± 0.01
    }
    
}
