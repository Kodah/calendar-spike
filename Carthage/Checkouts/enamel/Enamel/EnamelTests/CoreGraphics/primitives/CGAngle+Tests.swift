//
//  CGAngle+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 31/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGAngle_Tests: XCTestCase {
    
    func test_inRadians() {
        assert(-90.degrees.inRadians) ~= -π/2 ± 0.01
        assert(0.degrees.inRadians) ~= 0 ± 0.01
        assert(180.degrees.inRadians) ~= π ± 0.01
        assert(360.degrees.inRadians) ~= 2*π ± 0.01
        assert(450.degrees.inRadians) ~= (5*π)/2 ± 0.01
    }
    
    func test_equals() {
        assert(0.5.rotations == 180.degrees) == true
        assert(0.5.rotations == π.radians) == true
        assert(180.degrees == π.radians) == true
    }
    
    func test_zero_and_fullTurn() {
        assert(CGAngle.zero == 0.degrees) == true
        assert(CGAngle.fullTurn == 360.degrees) == true
    }
    
    func test_addition() {
        assert(0.5.rotations + 180.degrees) ~= 1.rotations ± 0.01
        assert(0.5.rotations + (2 * -π).radians) ~= -0.5.rotations ± 0.01
    }
    
    func test_subtraction() {
        assert(0.5.rotations - 180.degrees) ~= 0.rotations ± 0.01
        assert(0.5.rotations - (2 * -π).radians) ~= 1.5.rotations ± 0.01
    }
    
    func test_multiple() {
        assert(0.5.rotations * 5) ~= 2.5.rotations ± 0.01
        assert(0.5.rotations * 0) ~= 0.rotations ± 0.01
        assert(0.5.rotations * -5) ~= -2.5.rotations ± 0.01
    }
    
    func test_divide() {
        assert(0.5.rotations / 1000) ~= 0.0005.rotations ± 0.00001
        assert(0.5.rotations / 5) ~= 0.1.rotations ± 0.01
        assert(0.5.rotations / 0) == CGFloat.infinity.rotations
        assert(0.5.rotations / -5) ~= -0.1.rotations ± 0.00001
    }
}
