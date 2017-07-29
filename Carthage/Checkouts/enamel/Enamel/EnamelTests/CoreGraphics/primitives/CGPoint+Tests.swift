//
//  CGPoint+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 31/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGPoint_Tests: XCTestCase {

    func test_direction() {
        let point = CGPoint(x:1, y:1)
        assert(point.direction) ~= 45.degrees ± 0.01
    }
    
    func test_magnitude() {
        let point = CGPoint(x:3, y:4)
        assert(point.magnitude) ~= 5 ± 0.01
    }
    
    func test_abs() {
        let point = CGPoint(x:-1, y:-1)
        assert(point.abs) ~= CGPoint(x:1, y:1) ± 0.01
    }

    func test_floor() {
        let point = CGPoint(x:0.9, y:0.9)
        assert(point.floor) ~= CGPoint(x:0, y:0) ± 0.01
    }
    
    func test_ceil() {
        let point = CGPoint(x:0.1, y:0.1)
        assert(point.ceil) ~= CGPoint(x:1, y:1) ± 0.01
    }
    
    func test_with() {
        let point = CGPoint(x:0.1, y:0.1)
        let newPoint = point.with(x: 2, y: 2)
        assert(newPoint.x) ~= 2 ± 0.01
        assert(newPoint.y) ~= 2 ± 0.01
    }
    
    func test_offsetBy_tuple() {
        let point = CGPoint(x:1, y:1)
        let newPoint = point.offsetBy(CGPoint(x:2, y:2))
        assert(newPoint) ~= point+2 ± 0.01
    }
    
    func test_offsetBy_CGFloat() {
        let point = CGPoint(x:1, y:1)
        let newPoint = point.offsetBy(dx:2, dy:2)
        assert(newPoint) ~= point+2 ± 0.01
    }
    
    func test_offsetBy_angle() {
        let point = CGPoint.zero
        let newPoint = point.offsetBy(angle: -90.degrees, distance: 30)
        assert(newPoint) ~= CGPoint(x:0, y:-30) ± 0.01
    }


}
