//
//  CGRect+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 01/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGRect_Tests: XCTestCase {
    
    func test_anchor_negative_origin() {
        let rect = CGRect(center: CGPoint(x:-1, y:-1), square: 10)
        assert(rect.anchor(at: CGPoint(x:-1, y:-1))) ~= CGPoint(x:0.5, y:0.5) ± 0.01
        assert(rect.anchor(at: CGPoint(x:-6, y:-6))) ~= CGPoint(x:0, y:0) ± 0.01
        assert(rect.anchor(at: CGPoint(x:4, y:4))) ~= CGPoint(x:1, y:1) ± 0.01
        assert(rect.anchor(at: CGPoint(x:-6, y:4))) ~= CGPoint(x:0, y:1) ± 0.01
        assert(rect.anchor(at: CGPoint(x:4, y:-6))) ~= CGPoint(x:1, y:0) ± 0.01
    }
    
    func test_pointAtAnchor() {
        let rect = CGRect(center: CGPoint(x:-1, y:-1), square: 10)
        assert(rect.point(atAnchor: CGPoint(x:0.5, y:0.5))) ~= CGPoint(x:-1, y:-1) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:0, y:0))) ~= CGPoint(x:-6, y:-6) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:1, y:1))) ~= CGPoint(x:4, y:4) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:0, y:1))) ~= CGPoint(x:-6, y:4) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:1, y:0))) ~= CGPoint(x:4, y:-6) ± 0.01
    }
    
    func test_point_with_outside_anchor() {
        let rect = CGRect.unit
        
        assert(rect.point(atAnchor: CGPoint(x:2, y:2))) ~= CGPoint(x:2, y:2) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:-1, y:-1))) ~= CGPoint(x:-1, y:-1) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:-1, y:2))) ~= CGPoint(x:-1, y:2) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:2, y:-1))) ~= CGPoint(x:2, y:-1) ± 0.01
    }

    func test_anchor_with_point_outside_rect() {
        let rect = CGRect.unit
        
        assert(rect.anchor(at: CGPoint(x:2, y:2))) ~= CGPoint(x:2, y:2) ± 0.01
        assert(rect.anchor(at: CGPoint(x:-1, y:-1))) ~= CGPoint(x:-1, y:-1) ± 0.01
        assert(rect.anchor(at: CGPoint(x:-1, y:2))) ~= CGPoint(x:-1, y:2) ± 0.01
        assert(rect.anchor(at: CGPoint(x:2, y:-1))) ~= CGPoint(x:2, y:-1) ± 0.01
    }

}
