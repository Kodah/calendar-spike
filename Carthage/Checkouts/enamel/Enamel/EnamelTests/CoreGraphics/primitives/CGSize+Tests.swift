//
//  CGSize+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 31/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGSize_Tests: XCTestCase {
    
    func test_unit_is_one() {
        let size = CGSize.unit
        
        assert(size.width) ~= 1 ± 0.01
        assert(size.height) ~= 1 ± 0.01
    }
    
    func test_negative_size() {
        let size = CGSize(width: -1, height: -1)
        
        assert(size.width) ~= -1 ± 0.01
        assert(size.height) ~= -1 ± 0.01
    }
    
    func test_with_nothing() {
        let size = CGSize.unit
        let newSize = size.with()
        
        assert(newSize.width) ~= size.width ± 0.01
        assert(newSize.height) ~= size.height ± 0.01
    }

    func test_with() {
        let size = CGSize.unit
        let newSize = size.with(width: 10, height: 10)
        
        assert(newSize.width) ~= 10 ± 0.01
        assert(newSize.height) ~= 10 ± 0.01
    }
    
    func test_scale() {
        let size = CGSize.unit
        
        guard let scale = size.scale(toFit: CGSize(width: 5, height: 10)) else {
            XCTFail()
            return
        }
        
        assert(scale) ~= 5 ± 0.01
    }
    
    func test_size() {
        let size = CGSize.unit
        
        guard let newSize = size.size(toFit: CGSize(width: 5, height: 10)) else {
            XCTFail()
            return
        }
        
        assert(newSize.width) ~= 5 ± 0.01
        assert(newSize.height) ~= 5 ± 0.01
    }
    
    func test_size_negative_self() {
        let size = CGSize(width: -1, height: -1)
        let newSize = size.size(toFit: CGSize(width: 5, height: 10)).assertUnwrap()
        
        assert(newSize) ~= CGSize(width: 5, height: 5) ± 0.01
    }
    
    func test_size_negative_other() {
        let size = CGSize(width: 1, height: 1)
        let newSize = size.size(toFit: CGSize(width: -5, height: -10)).assertUnwrap()
        
        assert(newSize) ~= CGSize(width: 5, height: 5) ± 0.01
    }
    
    func test_size_negative_mix() {
        let size = CGSize(width: -1, height: 1)
        let otherSize = CGSize(width: 5, height: -10)
        
        let scale = size.scale(toFit: otherSize).assertUnwrap()
        assert(scale) ~= 5 ± 0.01
        
        let newSize = size.size(toFit: otherSize).assertUnwrap()
        assert(newSize) ~= CGSize(width: 5, height: 5) ± 0.01
    }
    
    func test_size_zero() {
        let size = CGSize.zero
        let newSize = size.size(toFit: CGSize(width: 5, height: 10))
        
        assert(newSize) == nil
    }

}
