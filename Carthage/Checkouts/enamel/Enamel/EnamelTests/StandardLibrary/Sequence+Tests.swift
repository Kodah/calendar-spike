//
//  Sequence.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 31/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Crack

class Sequence_Tests: XCTestCase {
    
    
    // MARK:- filterInOut
    
    func test_filterInOut_int() {
        let (inBag,outBag) = (1...10).filterInOut({ $0 <= 5 })
        
        assert(inBag) == (1...5).array
        assert(outBag) == (6...10).array
    }
    
    func test_filterInOut_decimal() {
        let (inBag,outBag) = [0.1, 0.2, 0.3, 0.4].filterInOut({ $0 <= 0.2 })
        
        assert(inBag) == [0.1, 0.2]
        assert(outBag) == [0.3, 0.4]
    }
    
    func test_filterInOut_String() {
        let (inBag,outBag) = Set(arrayLiteral: "a","b","c").filterInOut({ $0 < "b" })
        
        assert(inBag) == ["a"]
        assert(outBag.sorted()) == ["b", "c"]
    }

    func test_filterInOut_Empty() {
        let (inBag,outBag) = [].filterInOut({ $0 == 1 })
        
        assert(inBag) == []
        assert(outBag) == []
    }
    
    // MARK:- filter
    
    func test_filter() {
        assert([].filter(Int.self)) == []
        assert([""].filter(Int.self)) == []
        assert(["", ""].filter(Int.self)) == []
        assert([1].filter(Int.self)) == [1]
        assert([1, 2].filter(Int.self)) == [1, 2]
        assert(["", 1].filter(Int.self)) == [1]
        assert(["", 1, 2].filter(Int.self)) == [1, 2]
        assert(["", 2, 1].filter(Int.self)) != [1, 2]
        assert(["", 2, 1].filter(Int.self)) == [2, 1]
    }
    
    // MARK:- all
    
    func test_all_predicate() {
        assert([].all{ $0 == 1 }) == true
        assert([0].all{ $0 == 1 }) == false
        assert([1].all{ $0 == 1 }) == true
        assert([0, 0].all{ $0 == 1 }) == false
        assert([1, 0].all{ $0 == 1 }) == false
        assert([0, 1].all{ $0 == 1 }) == false
        assert([1, 1].all{ $0 == 1 }) == true
    }
    
    func test_all_type() {
        assert([].all(Int.self)) == true
        assert([0].all(Int.self)) == true
        assert([0, 1].all(Int.self)) == true
        assert([""].all(Int.self)) == false
        assert(["", ""].all(Int.self)) == false
        assert(["", 0].all(Int.self)) == false
    }
    
    // MARK:- any / contains
    
    func test_any_predicate() {
        assert([].any{ $0 == 1 }) == false
        assert([0].any{ $0 == 1 }) == false
        assert([1].any{ $0 == 1 }) == true
        assert([0, 0].any{ $0 == 1 }) == false
        assert([0, 1].any{ $0 == 1 }) == true
    }
    
    func test_any_type() {
        assert([].any(Int.self)) == false
        assert([""].any(Int.self)) == false
        assert([0, ""].any(Int.self)) == true
        assert([0, 0].any(Int.self)) == true
        assert(["", ""].any(Int.self)) == false

        assert([].contains(Int.self)) == false
        assert([""].contains(Int.self)) == false
        assert([0, ""].contains(Int.self)) == true
        assert([0, 0].contains(Int.self)) == true
        assert(["", ""].contains(Int.self)) == false
    }
    
    // MARK:- none
    
    func test_none_predicate() {
        assert([].none{ $0 == 1 }) == true
        assert([0].none{ $0 == 1 }) == true
        assert([1].none{ $0 == 1 }) == false
        assert([0, 0].none{ $0 == 1 }) == true
        assert([0, 1].none{ $0 == 1 }) == false
    }
    
    func test_none_type() {
        assert([].none(Int.self)) == true
        assert([""].none(Int.self)) == true
        assert([0, ""].none(Int.self)) == false
        assert([0, 0].none(Int.self)) == false
        assert(["", ""].none(Int.self)) == true
    }
    
    // MARK:- removeEach
    
    func test_remove_each() {
        var any = (1...10).array
        any.removeEach({ $0 > 5 })
        assert(any) == (1...5).array
    }
    
    func test_remove_each_empty() {
        var empty:[Int] = []
        empty.removeEach({ $0 > 5 })
        assert(empty) == []
    }
}
