//
//  Weak+Tests.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 16/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Crack

class Weak_Tests: XCTestCase {

    func test_weak_reference() {
        var o: NSObject? = NSObject()
        let w = Weak(o!)
        assert(w.object.isNotNil) == true
        o = nil
        assert(w.object.isNil) == true
    }
     
    func test_weak_set() {
        var o1: NSObject? = NSObject()
        var o2: NSObject? = NSObject()
        let set: Set<Weak<NSObject>> = [Weak(o1!), Weak(o2!)]
        assert(set.none{ $0.object.isNil }) == true
        (o1, o2) = (nil, nil)
        assert(set.all{ $0.object.isNil }) == true
    }
}
