//
//  NSStringAttribute.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 15/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public protocol NSStringAttributeType {
    var asStringAttribute: NSStringAttribute { get }
}

extension UIFont: NSStringAttributeType {
    public var asStringAttribute: NSStringAttribute { return .font(self) }
}

extension NSShadow: NSStringAttributeType {
    public var asStringAttribute: NSStringAttribute { return .shadow(self) }
}

extension UIColor: NSStringAttributeType {
    public var asStringAttribute: NSStringAttribute { return .color(self) }
}

public enum NSStringAttribute: NSStringAttributeType {
    
    case font(UIFont)
    case color(UIColor)
    case background(UIColor)
    case shadow(NSShadow)
    
    public var asStringAttribute: NSStringAttribute { return self }
    
    public var key: String {
        switch self {
        case .font: return NSFontAttributeName
        case .color: return NSForegroundColorAttributeName
        case .background: return NSBackgroundColorAttributeName
        case .shadow: return NSShadowAttributeName
        }
    }
    
    public var value: Any {
        switch self {
        case .font(let $): return $
        case .color(let $): return $
        case .background(let $): return $
        case .shadow(let $): return $
        }
    }
    
    public var pair: (String, Any) { return (key, value) }
}

public func == (lhs: NSStringAttribute, rhs: NSStringAttribute) -> Bool {
    switch (lhs, rhs) {
    case let (.font(l), .font(r)): return l == r
    case let (.color(l), .color(r)): return l == r
    case let (.background(l), .background(r)): return l == r
    case let (.shadow(l), .shadow(r)): return l == r
    default: return false
    }
}

extension NSStringAttribute: Hashable {
    public var hashValue: Int {
        return key.hashValue
    }
}

extension Sequence where Iterator.Element == NSStringAttribute {
    
    public var keys: Set<String> { return map{ $0.key }.set }
    
    public var pairs: [(String, Any)] { return map{ $0.pair } }
    
    public var dictionary: [String:Any] { return Dictionary(pairs) }
    
    public func with(_ other: NSStringAttributeType...) -> Set<NSStringAttribute> {
        return with(other)
    }
    
    public func with(_ other: NSStringAttribute...) -> Set<NSStringAttribute> {
        return with(other)
    }
    
    public func with<Attributes>(_ other: Attributes) -> Set<NSStringAttribute>
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        return with(other.stringAttributes)
    }

    public func with<Attributes>(_ other: Attributes) -> Set<NSStringAttribute>
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttribute
    {
        let keys = other.keys
        return filter{ keys.doesNotContain($0.key) }.set.union(other)
    }
}

extension Sequence where Iterator.Element == NSStringAttributeType {
    
    public var stringAttributes: Set<NSStringAttribute> {
        return map{ $0.asStringAttribute }.set
    }
    
    public var dictionary: [String:Any] {
        return stringAttributes.dictionary
    }
    
    public func with(_ attributes: NSStringAttributeType...) -> Set<NSStringAttribute> {
        return stringAttributes.with(attributes)
    }
    
    public func with<Attributes>(_ other: Attributes) -> Set<NSStringAttribute>
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        return stringAttributes.with(other)
    }
}

extension Sequence where Iterator.Element: NSStringAttributeType {
    
    public var stringAttributes: Set<NSStringAttribute> {
        return map{ $0.asStringAttribute }.set
    }
    
    public var dictionary: [String:Any] {
        return stringAttributes.dictionary
    }
    
    public func with(_ attributes: NSStringAttributeType...) -> Set<NSStringAttribute> {
        return stringAttributes.with(attributes)
    }
    
    public func with<Attributes>(_ other: Attributes) -> Set<NSStringAttribute>
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        return stringAttributes.with(other)
    }
}
