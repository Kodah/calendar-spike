//
//  Asserted.swift
//  Crack
//
//  Created by Rankovic, Milos (Developer) on 02/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public func assert<T>(
    _ x: T,
    function: String = #function,
    file: String = #file,
    line: Int = #line)
    -> Asserted<T>
{
    return Asserted(x, function: function, file: file, line: line)
}

public struct Asserted<T> {
    public let value: T
    public let function: String
    public let file: String
    public let line: Int
    
    public var prettyFunc: String {
        return function.description
            .replacingOccurrences(of: "_", with: " ")
            .trimmingCharacters(in: CharacterSet(charactersIn: "()"))
    }
    
    public init(
        _ x: T,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
    {
        self.value = x
        self.function = function
        self.file = file
        self.line = line
    }
    
    fileprivate func failed(function: String = #function, arguments: String...) {
        var msg = "🐞 Failed \(prettyFunc): \(value) \(function)"
        msg += arguments.isEmpty ? "" : " with arguments \(arguments)"
        fail(msg, expected: true, function: self.function, file: file, line: line)
    }
}

extension Asserted where T: Collection {
    
    public func isEmpty() {
        if !value.isEmpty { failed() }
    }
    
    public func isNotEmpty() {
        if value.isEmpty { failed() }
    }
}

extension Asserted where T: Collection, T.Iterator.Element: Equatable {
    
    public func contains(_ element: T.Iterator.Element) {
        if !value.contains(element) {
            failed(arguments: "\(element)")
        }
    }
    
    public func doesNotContain(_ element: T.Iterator.Element) {
        if value.contains(element) {
            failed(arguments: "\(element)")
        }
    }
}

