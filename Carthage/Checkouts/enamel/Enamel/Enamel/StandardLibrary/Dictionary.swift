//
//  Dictionary.swift
//  SwiftSky
//
//  Created by milos on 20/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

/// Equivalent to `lhs.merged(rhs)`
public func + <A,B>(lhs: [A:B], rhs: [A:B]) -> [A:B] {
    return lhs.merging(rhs)
}

/// Equivalent to `lhs.merge(rhs)`
public func += <A,B>(lhs: inout [A:B], rhs: [A:B]) {
    lhs.merge(rhs)
}

public extension Dictionary {
    
    /// Returning a union of `self` and `other`, opting for values in `other` where keys are equal.
    public func merging(_ other: Dictionary) -> Dictionary {
        var o = self
        o.merge(other)
        return o
    }
    
    /// Forms a union of `self` and `other`, opting for values in `other` where keys are equal.
    public mutating func merge(_ other: Dictionary) {
        for (k, v) in other { self[k] = v }
    }
}

public extension Dictionary {
    
    // Originally implemented by Jon Cotton on 19 Dec 2016
    
    /// Returning a union of `self` and `other`, opting for values in `other` where keys are equal
    /// *at any depth of branching hierarchy* where `self is Value` (and so `Value == Any`),
    /// else returns `self.merge(other)`
    public func deepMerging(_ other: Dictionary) -> Dictionary {
        var o = self
        o.deepMerge(other)
        return o
    }
    
    /// Forms a union of `self` and `other`, opting for values in `other` where keys are equal
    /// *at any depth of branching hierarchy* where `self is Value` (and so `Value == Any`),
    /// else returns `self.merge(other)`
    public mutating func deepMerge(_ other: Dictionary) {
        guard self is Value else {
            return merge(other)
        }
        for (key, value) in other {
            if
                let thisBranch = self[key] as? Dictionary,
                let otherBranch = other[key] as? Dictionary,
                let mergedBranch = thisBranch.deepMerging(otherBranch) as? Value
            {
                self[key] = mergedBranch
            } else {
                self[key] = value
            }
        }
    }
}

public extension Dictionary {
    
    public init<Pairs>(_ pairs: Pairs)
        where
        Pairs: Collection,
        Pairs.Iterator.Element == (key: Key, value: Value),
        Pairs.IndexDistance == Int
    {
        var o = Dictionary(minimumCapacity: pairs.count)
        pairs.forEach{ o[$0.0] = $0.1 }
        self = o
    }
    
    public init<Pairs>(_ pairs: Pairs) where Pairs: Sequence, Pairs.Iterator.Element == (key: Key, value: Value) {
        var o = Dictionary()
        pairs.forEach{ o[$0.0] = $0.1 }
        self = o
    }
    
    // now, all the above again, but for `(Key, Value)` as opposed to `(key: Key, value: Value)` :(
    
    public init<Pairs>(_ pairs: Pairs)
        where
        Pairs: Collection,
        Pairs.Iterator.Element == (Key, Value),
        Pairs.IndexDistance == Int
    {
        var o = Dictionary(minimumCapacity: pairs.count)
        pairs.forEach{ o[$0.0] = $0.1 }
        self = o
    }
    
    public init<Pairs>(_ pairs: Pairs) where Pairs: Sequence, Pairs.Iterator.Element == (Key, Value) {
        var o = Dictionary()
        pairs.forEach{ o[$0.0] = $0.1 }
        self = o
    }
}

public extension Zip2Sequence where Sequence1.Iterator.Element: Hashable {
    
    public typealias Key = Sequence1.Iterator.Element
    public typealias Value = Sequence2.Iterator.Element
    
    public var dictionary: [Key:Value] {
        return Dictionary(self)
    }
}

public extension Dictionary {
    
    /**
     Subscript with an additional parameter for the default value.
     ```
     var d: [String:Int] = [:]
     for i in 1...7 {
         if i % 2 == 0 {
             d["even", else: 0] += 1
         } else {
             d["odd", else: 0] += 1
         }
     }
     print("total", d) //--> total ["odd": 4, "even": 3]
     ```
     - returns: Non-optional `Value`.
     */
    public subscript(key: Key, else defaultValue: @autoclosure () -> Value) -> Value {
        // TODO: note https://github.com/apple/swift-evolution/blob/master/proposals/0154-dictionary-key-and-value-collections.md
        get {
            return self[key] ?? defaultValue()
        }
        set {
            self[key] = newValue
        }
    }
}

public extension Dictionary {
    
    /*
     TODO: write a more elegant alternative when generic subscripts become available in Swift 4:
     https://github.com/apple/swift-evolution/blob/master/proposals/0148-generic-subscripts.md
     */
    public func get<T>(_ key: Key, as _: T.Type, function: String = #function, file: String = #file, line: Int = #line) throws -> T {
        guard let o = self[key] else {
            throw GetError<Key, Value>.noValueForKey(
                keyDescription: "\(key)",
                path: path(function: function, file: file, line: line)
            )
        }
        guard let t = o as? T else {
            throw GetError<Key, Value>.castError(
                valueDescription: "\(o)",
                destinationType: T.self,
                path: path(function: function, file: file, line: line)
            )
        }
        return t
    }
    
    public func get<T>(_ key: Key, else defaultValue: @autoclosure () -> T) -> T {
        return self[key] as? T ?? defaultValue()
    }
    
    public enum GetError<Key, Value>: Error, CustomStringConvertible {
        
        case noValueForKey(keyDescription: String, path: String)
        case castError(valueDescription: String, destinationType: Any.Type, path: String)
        
        public var description: String {
            switch self
            {
            case let .noValueForKey(key):
                return "\(type(of: self)): No value for key '\(key)'."
                
            case let .castError(valueDescription, destinationType, path):
                return "\(type(of: self)): Failed to cast '\(valueDescription)' to type \(destinationType) ← \(path)"
            }
        }
    }
}

public extension Dictionary {
    
    public subscript(_ firstValueWhereKeyMatches: (Key) -> Bool) -> Value? {
        return firstValue(where: firstValueWhereKeyMatches)
    }

    public func firstValue(where predicate: (Key) throws -> Bool) rethrows -> Value? {
        return try first{ try predicate($0.0) }?.1
    }
}
