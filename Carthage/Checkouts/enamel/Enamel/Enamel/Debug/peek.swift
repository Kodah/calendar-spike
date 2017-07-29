//
//  peek.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 02/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension CustomStringConvertible {
    
    @discardableResult
    public func peek<T>(
        _ autoclosure: @autoclosure () -> T,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> Self
    {
        #if DEBUG
            return self.peek("\(autoclosure())", function: function, file: file, line: line)
        #else
            return self
        #endif
    }
    
    @discardableResult
    public func peek(
        _ message: String = "",
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> Self
    { 
        #if DEBUG
            let p = path(function: function, file: file, line: line)
            print("\(message)\(message.isEmpty ? "" : ": ")\(self) ← \(p)")
        #endif
        return self
    }
}
