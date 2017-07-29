//
//  String+UIKit.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 16/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension String {
    
    public func with(_ attributes: NSStringAttribute...) -> NSAttributedString {
        return with(attributes)
    }
    
    public func with(_ attributes: NSStringAttributeType...) -> NSAttributedString {
        return with(attributes)
    }
    
    public func with<Attributes>(_ attributes: Attributes)
        -> NSAttributedString
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttribute
    {
        return NSAttributedString(string: self, attributes: attributes.dictionary)
    }
    
    public func with<Attributes>(_ attributes: Attributes)
        -> NSAttributedString
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        return NSAttributedString(string: self, attributes: attributes.dictionary)
    }

    // MARK:- deprecated
    
    @available(*, deprecated, renamed: "with(_:)")
    public func attributedWith(_ attributes: NSStringAttribute...) -> NSAttributedString {
        return with(attributes)
    }
    
    @available(*, deprecated, renamed: "with(_:)")
    public func attributedWith(_ attributes: NSStringAttributeType...) -> NSAttributedString {
        return with(attributes)
    }
    
    @available(*, deprecated, renamed: "with(_:)")
    public func attributedWith<Attributes>(_ attributes: Attributes)
        -> NSAttributedString
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttribute
    {
        return with(attributes)
    }
    
    @available(*, deprecated, renamed: "with(_:)")
    public func attributedWith<Attributes>(_ attributes: Attributes)
        -> NSAttributedString
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        return with(attributes)
    }
}
