//
//  CGRect+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 01/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGRect_iOSTests: XCTestCase {
    
    func test_anchor_from() {
        let rect = CGRect.unit
        assert(rect.anchor(at: CGPoint(x:0.25, y:0.25))) ~= CGPoint(x:0.25, y:0.25) ± 0.01
        
        assert(rect.anchor(at: CGPoint(x:0.25, y:0.25), from: .topLeft)) ~= CGPoint(x:0.25, y:0.25) ± 0.01
        assert(rect.anchor(at: CGPoint(x:0.25, y:0.25), from: .bottomLeft)) ~= CGPoint(x:0.25, y:0.75) ± 0.01
    }
    
    func test_point_from() {
        let rect = CGRect.unit
        assert(rect.point(atAnchor: CGPoint(x:0.25, y:0.25), from: CGGeometry.Origin.topLeft)) ~= CGPoint(x:0.25, y:0.25) ± 0.01
        assert(rect.point(atAnchor: CGPoint(x:0.25, y:0.25), from: CGGeometry.Origin.bottomLeft)) ~= CGPoint(x:0.25, y:0.75) ± 0.01
    }
}
