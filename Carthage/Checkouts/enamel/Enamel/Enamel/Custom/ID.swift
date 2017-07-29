//
//  IDProtocol.swift
//  Store
//
//  Created by milos on 10/07/2016.
//  Copyright © 2016 Milos. All rights reserved.
//

// TODO: Implement Hydratable & Dehydratable

public protocol HasID {
    var id: ID { get }
}

public extension HasID {
    public var hashValue: Int { return id.hashValue }
    public func derives(from other: Self) -> Bool { return id.derives(from: other.id) }
    public func sameVersion(of other: Self) -> Bool { return id.sameVersion(of: other.id) }
}

/// Equivalent to `lhs.string == rhs.string`
///
public func == <I: HasID>(lhs: I, rhs: I) -> Bool {
    return lhs.id == rhs.id
}

/// Equivalent to `sameVersion(of:)`
///
public func === <I: HasID>(lhs: I, rhs: I) -> Bool {
    return lhs.sameVersion(of: rhs)
}

public struct ID: Hashable {

    public let string: String
    public let version: UInt
    
    public var newVersion: ID { return ID(id: self) }
    
    public var hashValue: Int { return string.hashValue }
    
    public init(uri string: String? = nil, version: UInt = 1) {
        self.string = string ?? UUID().uuidString
        self.version = version
    }
    
    private init(id: ID) {
        string = id.string
        version = id.version &+ 1
    }
    
    /// Equivalent to `lhs.string == rhs.string`
    ///
    public static func == (lhs: ID, rhs: ID) -> Bool {
        return lhs.string == rhs.string
    }
    
    /// Equivalent to `sameVersion(of:)`
    ///
    public static func === (lhs: ID, rhs: ID) -> Bool {
        return lhs.sameVersion(of: rhs)
    }
    
    public func sameVersion(of other: ID) -> Bool {
        return self == other && version == other.version
    }
    
    public func derives(from other: ID) -> Bool {
        return self == other && version > other.version
    }
}

extension ID: CustomStringConvertible {
    public var description: String {
        return "ID(string: \(string), version: \(version))"
    }
}
