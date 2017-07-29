//
//  String.swift
//  SwiftSky
//
//  Created by milos on 20/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public func * (lhs: String, rhs: Int) -> String {
    return Array(repeating: lhs, count: max(0, rhs)).joined(separator: "")
}

/// Allows you to `throw "A string directly"`.
extension String: Error {}

public extension String {
    
    public var isNotEmpty: Bool { return !isEmpty }

    public func nonEmpty(else defaultValue: String) -> String {
        return self == "" ? defaultValue : self
    }
    
    /**
     Removing dependency on `NSString.lastPathComponent` property
     so that debug functions do not need to import `Foundation`.
     */
    public var lastPOSIXPathComponent: String {
        var start = startIndex
        var end: String.Index?
        for (i, c) in zip(characters.indices, characters).reversed() {
            if end == nil {
                if c != "/" || i == start {
                    end = index(after: i)
                }
            } else if c == "/" {
                start = index(after: i)
                break
            }
        }
        return substring(with: start..<(end ?? start))
    }
}
