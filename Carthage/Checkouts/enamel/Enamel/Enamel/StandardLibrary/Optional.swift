//
//  Optional.swift
//  SwiftSky
//
//  Created by milos on 20/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension Optional {
    
    public var isNil: Bool { return self == nil }
    public var isNotNil: Bool { return self != nil }
    
    public func unwrapped<T>(else defaultValue: @autoclosure () -> T) -> T {
        return (self as? T) ?? defaultValue()
    }
    
    public func unwrap(orThrow error: Error? = nil) throws -> Wrapped {
        if case let unwrapped? = self { return unwrapped }
        throw error ?? "Trying to unwrap Optional<\(Wrapped.self)>.none"
    }
    
    public static func ??^ (optional: Optional, error: Error) throws -> Wrapped {
        return try optional.unwrap(orThrow: error)
    }
    
    public func forceUnwrappedInDEBUG(else defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        #if DEBUGx
            return self!
        #else
            return self ?? defaultValue()
        #endif
    }
    
    public static func ??! (optional: Optional, defaultValue: @autoclosure () -> Wrapped) -> Wrapped {
        return optional.forceUnwrappedInDEBUG(else: defaultValue)
    }
}

public extension Optional {
    
    @available(*, unavailable, renamed: "forSome(_:)")
    public func apply(_ closure: (Wrapped) throws -> ()) rethrows {}
    
    public func forSome(_ closure: (Wrapped) throws -> ()) rethrows {
        if let o = self { try closure(o) }
    }
    
    public func ifNotNil(do closure: (Wrapped) throws -> ()) rethrows {
        try forSome(closure)
    }
    
    public func unlessNil(do closure: (Wrapped) throws -> ()) rethrows {
        try forSome(closure)
    }
}



public extension Optional {
    
    public func map<T>(_ type: T.Type) -> T? {
        return self as? T
    }
}

// Makes `Optional`s `peek`able
extension Optional: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .none: return "nil \(Wrapped.self)"
        case let .some(x): return "\(x)?"
        }
    }
}
