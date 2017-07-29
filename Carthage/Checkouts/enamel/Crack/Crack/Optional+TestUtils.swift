//
//  Optional+TestUtils.swift
//  Crack
//
//  Created by Rankovic, Milos (Developer) on 03/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

extension Optional {
    
    public func assertUnwrap(function: String = #function, file: String = #file, line: Int = #line) -> Wrapped {
        switch self {
        case .some(let value):
            return value
            
        case .none:
            fatal(
                "🚫 Asserted unwrap of \(type(of: self)) failed!",
                function: function,
                file: file,
                line: line
            )
        }
    }
}

extension Optional {
    
    public var string: String {
        switch self {
        case .some(let value): return String(describing: value)
        case .none: return "nil"
        }
    }
}
