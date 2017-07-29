//
//  String+Foundation.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 19/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public extension NSString {
    
    public var range: NSRange { return NSRange(location: 0, length: length) }
}

public extension String {
    
    public var nsRange: NSRange { return (self as NSString).range }
    
    public func with(attributes: [String:Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}

// MARK:- URL

public func toURL(allowing allowedCharacters: CharacterSet) -> (String) -> URL? {
    return { $0.url(allowing: allowedCharacters) }
}

public extension String {
    
    public var url: URL? { return URL(string: self) }
    
    public func url(allowing allowedCharacters: CharacterSet) -> URL? {
        return urlEncoded(allowing: allowedCharacters).flatMap(URL.init)
    }
    
    public func urlEncoded(allowing allowedCharacters: CharacterSet) -> String? {
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
}
