//
//  Collection+Tests.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 31/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Crack

class Collection_Tests: XCTestCase {
    
    func test_index_of_type() {
        assert([].index(of: Int.self)) == nil
        assert([""].index(of: Int.self)) == nil
        assert(["", ""].index(of: Int.self)) == nil
        assert([1].index(of: Int.self)) == 0
        assert([1, 2].index(of: Int.self)) == 0
        assert(["", 1].index(of: Int.self)) == 1
        assert(["", 1, ""].index(of: Int.self)) == 1
        assert(["", "", 1, ""].index(of: Int.self)) == 2
        assert(["", "", 1, 1].index(of: Int.self)) == 2
    }
    
    func test_index_of_type_collection() {
        let any: [Any] = [Set(arrayLiteral: 2,3), [0.5], ["key":5], Set(arrayLiteral: 2,3), [0.5], ["key":5]]
        
        assert(any.index(of: Set<Int>.self)) == 0
        assert(any.index(of: Array<Double>.self)) == 1
        assert(any.index(of: Dictionary<String,Int>.self)) == 2
    }
    
    func test_lastIndex_of_type() {
        assert([].lastIndex(of: Int.self)) == nil
        assert([""].lastIndex(of: Int.self)) == nil
        assert(["", ""].lastIndex(of: Int.self)) == nil
        assert([1].lastIndex(of: Int.self)) == 0
        assert([1, 2].lastIndex(of: Int.self)) == 1
        assert(["", 1].lastIndex(of: Int.self)) == 1
        assert(["", 1, ""].lastIndex(of: Int.self)) == 1
        assert(["", "", 1, ""].lastIndex(of: Int.self)) == 2
        assert(["", "", 1, 1].lastIndex(of: Int.self)) == 3
    }
    
    func test_lastIndex_of_type_collection() {
        let any: [Any] = [Set(arrayLiteral: 2,3), [0.5], ["key":5], Set(arrayLiteral: 2,3), [0.5], ["key":5]]
        
        assert(any.lastIndex(of: Set<Int>.self)) == 3
        assert(any.lastIndex(of: Array<Double>.self)) == 4
        assert(any.lastIndex(of: Dictionary<String,Int>.self)) == 5
    }
    
    func test_lastIndex_where_predicate() {
        assert([].lastIndex{ $0 == 1 }) == nil
        assert([0].lastIndex{ $0 == 1 }) == nil
        assert([1].lastIndex{ $0 == 1 }) == 0
        assert([1, 1].lastIndex{ $0 == 1}) == 1
    }
    
    func test_first_type() {
        assert([].first(Int.self)) == nil
        assert([""].first(Int.self)) == nil
        assert(["", ""].first(Int.self)) == nil
        assert(["", 1, ""].first(Int.self)) == 1
        assert(["", 1, 2].first(Int.self)) == 1
    }
    
    func test_last_type() {
        assert([].last(Int.self)) == nil
        assert([""].last(Int.self)) == nil
        assert(["", ""].last(Int.self)) == nil
        assert(["", 1, ""].last(Int.self)) == 1
        assert(["", 1, 2].last(Int.self)) == 2
    }
    
    func test_last_where_predicate() {
        assert([].last{ $0 > 1 }) == nil
        assert([1].last{ $0 > 1 }) == nil
        assert([1, 2].last{ $0 > 1 }) == 2
        assert([1, 2, 3].last{ $0 > 1 }) == 3
        assert([1, 2, 3, 0].last{ $0 > 1 }) == 3
    }
}
