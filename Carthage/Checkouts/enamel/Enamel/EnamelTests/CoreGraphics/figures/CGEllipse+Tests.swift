//
//  CGEllipse+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 27/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGEllipse_Tests: XCTestCase {
    
    // MARK:- Scale
    
    func test_ellipse_scaled_by_decimal() {
        let ellipse = CGEllipse(center: .zero, xRadius: 10, yRadius: 5)
        let newEllipse = ellipse.scaled(by: 0.5)
        assert(newEllipse.xRadius) ~= 10 * 0.5 ± 0.01
        assert(newEllipse.yRadius) ~= 5 * 0.5 ± 0.01
    }
    
    func test_ellipse_scaled_by_negative() {
        let ellipse = CGEllipse(center: .zero, xRadius: 10, yRadius: 5)
        let newEllipse = ellipse.scaled(by: -2)
        assert(newEllipse.xRadius) ~= 10 * -2 ± 0.01
        assert(newEllipse.yRadius) ~= 5 * -2 ± 0.01
    }
    
    func test_ellipse_scaled_by_zero() {
        let ellipse = CGEllipse(center: .zero, xRadius: 10, yRadius: 5)
        
        let newEllipse = ellipse.scaled(by: 0)
        assert(newEllipse.xRadius) ~= 0 ± 0.01
        assert(newEllipse.yRadius) ~= 0 ± 0.01
    }
    
    // MARK:- Resized
    
    func test_circle_resized() {
        let ellipse = CGEllipse(center: .zero, xRadius: 10, yRadius: 5)
        
        let positivelyResizedEllipse = ellipse.resized(by: 10)
        let negativelyResizedEllipse = ellipse.resized(by: -10)
        
        assert(positivelyResizedEllipse.xRadius) ~= 10 + 10 ± 0.01
        assert(positivelyResizedEllipse.yRadius) ~= 5 + 10 ± 0.01
        
        assert(negativelyResizedEllipse.xRadius) ~= 10 - 10 ± 0.01
        assert(negativelyResizedEllipse.yRadius) ~= 5 - 10 ± 0.01
    }
    
}
