//
//  ID+Tests.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 01/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class ID_Tests: XCTestCase {
    
    struct A: HasID {
        let id: ID
        init() { id = ID() }
        init(from other: A) { id = other.id.newVersion }
    }
    
    func test_derives() {
        let a = A()
        assert(a == a) == true
        assert(a === a) == true
        assert(a.derives(from: a)) == false
        
        let a2 = a
        assert(a == a2) == true
        assert(a === a2) == true
        assert(a2.derives(from: a)) == false
        
        let a3 = A(from: a)
        assert(a == a3) == true
        assert(a === a3) == false
        assert(a3.derives(from: a)) == true
    }
    
    func test_sameVersion() {
        let a = A()
        let a2 = a

        assert(a == a2) == true
        assert(a === a2) == true
        assert(a.sameVersion(of: a2)) == true
    }
    
    func test_differentVersion() {
        let a = A()
        let a2 = A()

        assert(a == a2) == false
        assert(a === a2) == false
        assert(a.sameVersion(of: a2)) == false
    }
}
