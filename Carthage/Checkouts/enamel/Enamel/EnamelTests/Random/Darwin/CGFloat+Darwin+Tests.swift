//
//  CGFloat+Darwin+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 30/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGFloat_Darwin_Tests: XCTestCase {
    
    func test_random_walk() {
        
        let range: CGFloat = 0.5
        
        let walk = CGFloat.randomWalk(count: 100, initial: 0, range: range)
        for (i, x) in walk.enumerated() {
            let prevIndex = i-1
            
            if prevIndex >= 0 {
                let max = walk[prevIndex]+range
                let min = walk[prevIndex]-range
                assert(x<=max && x>=min) == true
            }
        }
    }
    
    func test_random_swapped_between() {
        
        let random = CGFloat.random(between: 10, and: -10)
        assert(random <= 10 || random >= -10) == true
    }
    
    func test_random_zero() {
        
        let random = CGFloat.random(between: 0, and: 0)
        assert(random == 0) == true
    }
}
