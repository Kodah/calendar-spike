//
//  CGTick+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGTick_Tests: XCTestCase {
    
    func test_equatable() {
        let originalTick = CGTick(rect: .unit)
        let unitTick = CGTick(rect: .unit)
        let largerTick = CGTick(rect: CGRect(x: 0, y: 0, width: 2, height: 2))
        let notOriginTick = CGTick(rect: CGRect(x: 2, y: 2, width: 1, height: 1))

        assert(originalTick) == originalTick
        assert(originalTick) == unitTick
        assert(originalTick) != largerTick
        assert(originalTick) != notOriginTick
    }
}
