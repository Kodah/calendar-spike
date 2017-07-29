//
//  NSRegularExpression.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 08/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public extension NSRegularExpression {
    
    public static func ~= (lhs: NSRegularExpression, rhs: String) -> Bool {
        return lhs.rangeOfFirstMatch(in: rhs, options: [], range: rhs.nsRange).location != NSNotFound
    }
}

public extension NSRegularExpression.Options {
    
    public static let i = NSRegularExpression.Options.caseInsensitive
    public static let x = NSRegularExpression.Options.allowCommentsAndWhitespace
    public static let m = NSRegularExpression.Options.dotMatchesLineSeparators
}

public extension String {
    
    public var regex: NSRegularExpression? { return try? regex() }
    
    public func regex(_ options: NSRegularExpression.Options...) throws -> NSRegularExpression {
        return try regex(NSRegularExpression.Options(options))
    }
    
    public func regex(_ options: NSRegularExpression.Options) throws -> NSRegularExpression {
        return try NSRegularExpression(pattern: self, options: options)
    }
}
