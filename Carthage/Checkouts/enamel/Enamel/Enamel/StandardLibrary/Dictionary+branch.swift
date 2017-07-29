//
//  Dictionary+branch.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 22/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- branch into a nested object with a key path

// TODO: write a more elegant alternative when generic subscripts become available:
// https://github.com/apple/swift-evolution/blob/master/proposals/0148-generic-subscripts.md

public extension Dictionary {
    
    public func branch(_ keyPath: [Key]) throws -> Dictionary {
        var o = self
        for key in keyPath {
            guard let object = o[key] else {
                throw BranchingError(
                    info: "Value not found for key '\(key)'",
                    type: type(of: o),
                    key: key,
                    data: o
                )
            }
            guard let branch = object as? Dictionary else {
                throw BranchingError(
                    info: "Value for key '\(key)' could not be converted to [\(Key.self):\(Value.self)]",
                    type: type(of: object),
                    key: key,
                    data: object
                )
            }
            o = branch
        }
        return o
    }
    
    public func branch(_ keyPath: Key...) throws -> Dictionary {
        return try branch(keyPath)
    }
    
    public func branch(_ keyPath: Key..., else defaultValue: @autoclosure () -> Dictionary) -> Dictionary {
        do {
            return try branch(keyPath)
        } catch {
            return defaultValue()
        }
    }
}

// MARK:- branches

public extension Dictionary {
    
    public func branches(_ keyPath: [Key]) throws -> [Dictionary] {
        guard let key = keyPath.last else {
            throw BranchingError(
                info: "Dictionary.\(#function) requires at least one key",
                type: Dictionary.self,
                key: keyPath,
                data: self
            )
        }
        var dictionary = keyPath.count > 1 ? try branch(keyPath.dropLast().array) : self
        guard let object = dictionary[key] else {
            throw BranchingError(
                info: "Value not found for key '\(key)'",
                type: type(of: dictionary),
                key: key,
                data: dictionary
            )
        }
        guard let branches = object as? [Dictionary] else {
            throw BranchingError(
                info: "Value for key '\(key)' could not be converted to [[\(Key.self):\(Value.self)]]",
                type: type(of: object),
                key: key,
                data: object
            )
        }
        return branches
    }
    
    public func branches(_ firstKey: Key, _ restOfKeyPath: Key...) throws -> [Dictionary] {
        return try branches([firstKey] + restOfKeyPath)
    }
    
    public func branches(
        _ firstKey: Key, _ restOfKeyPath: Key...,
        else defaultValue: @autoclosure () -> [Dictionary]
        ) -> [Dictionary]
    {
        do {
            return try branches([firstKey] + restOfKeyPath)
        } catch {
            return defaultValue()
        }
    }
}

// MARK:- branch into a listed object with a key path

public extension Dictionary {
    
    public func branch(_ key: Key, where predicate: (Dictionary) -> Bool) throws -> Dictionary {
        guard let value = self[key] else {
            throw BranchingError(
                info: "Value not found for key '\(key)'",
                type: Dictionary.self,
                key: key,
                data: self
            )
        }
        guard let array = value as? [Any] else {
            throw BranchingError(
                info: "Value for key '\(key)' could not be converted to [Any]",
                type: Dictionary.self,
                key: key,
                data: self
            )
        }
        for e in array {
            if let e = e as? Dictionary, predicate(e) {
                return e
            }
        }
        throw BranchingError(
            info: "No branch found for key '\(key)' that matches the predicate",
            type: Dictionary.self,
            key: key,
            data: self
        )
    }
    
    public func branch(
        _ key: Key,
        where predicate: (Dictionary) -> Bool,
        else defaultValue: @autoclosure () -> Dictionary
        ) -> Dictionary
    {
        do {
            return try branch(key, where: predicate)
        } catch {
            return defaultValue()
        }
    }
}


// TODO: This has exactly the same shape as `HydratingError` - refactor into a protocol?
public struct BranchingError: Error, HasID {
    
    public let info: String?
    let type: Any.Type?
    let key: Any?
    let data: Any?
    let locationInCode: String
    
    public let id = ID()
    
    public init(
        info: String? = nil,
        type: Any.Type? = nil,
        key: Any? = nil,
        data: Any? = nil,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
    {
        self.info = info
        self.type = type
        self.key = key
        self.data = data
        self.locationInCode = path(function: function, file: file, line: line)
    }
}

// MARK:- Serialization TODO

extension BranchingError: Dehydratable {
    public func dehydrate() -> [String: Any] {
        var $: [String: Any] = ["location": locationInCode]
        $["info"] = info
        $["type"] = type.map{ String(describing: $0) }
        $["key"] = key.map{ String(describing: $0) }
        $["data"] = (data as? NSDictionary) ?? data.map{ String(describing: $0) }
        return $
    }
}
