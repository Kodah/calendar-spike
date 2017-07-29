//
//  poke.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 24/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension CustomStringConvertible {
    
    @discardableResult
    public func poke<T: CustomStringConvertible>(
        _ what: String = "",
        function: String = #function,
        file: String = #file,
        line: Int = #line, _
        selector: (Self) -> T)
        -> Self
    {
        #if DEBUG
            _ = selector(self).peek(what, function: function, file: file, line: line)
        #endif
        return self
    }
}
