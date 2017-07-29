//
//  XCTestCase.swift
//  State
//
//  Created by Rankovic, Milos (Developer) on 13/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

extension XCTestCase {
    
    public class var thisBundle: Bundle {
        return Bundle(for: self)
    }
    
    public var thisBundle: Bundle {
        return Bundle(for: type(of: self))
    }
}

extension XCTestCase {
    
    public func expectation(
        _ description: String = "Promise",
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> XCTestExpectation
    {
        let origin = path(function: function, file: file, line: line)
        return expectation(description: "💔 \(description) timed out: \(origin)")
    }
}
