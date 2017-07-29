//
//  fail+fatal.swift
//  Crack
//
//  Created by Rankovic, Milos (Developer) on 20/03/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public func fail<T>(_ lhs: Asserted<T>, _ rhs: T, function: String = #function) {
    let msg = "🐞 Failed \(lhs.prettyFunc): \(lhs.value) \(function) \(rhs)"
    fail(msg, function: function, file: lhs.file, line: lhs.line)
}

public func fail(
    _ description: String = "Failed",
    expected: Bool = true,
    function: String = #function,
    file: String = #file,
    line: Int = #line)
{
    if let testCase = RunningTestCase {
        testCase.recordFailure(
            withDescription: description,
            inFile: file.description,
            atLine: UInt(line),
            expected: false
        )
        if !expected { testCase.testRun?.stop() }
    } else {
        print(description, "←", path(function: function, file: file, line: line))
        fatalError("💥 \(#function) called outside running test case! See ↑")
    }
}

public func fatal(
    _ description: String,
    function: String,
    file: String,
    line: Int)
    -> Never
{
    fail(description, expected: false, function: function, file: file, line: line)
    exit(0)
}
