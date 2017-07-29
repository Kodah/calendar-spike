//
//  SelflessEquatable.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 06/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public protocol SelflessEquatable {
    func isSelflessEqual(to other: SelflessEquatable) -> Bool
}
public extension SelflessEquatable {
    func isNotSelflessEqual(to other: SelflessEquatable) -> Bool {
        return !isSelflessEqual(to: other)
    }
}

public extension SelflessEquatable where Self: Equatable {
    public func isSelflessEqual(to other: SelflessEquatable) -> Bool {
        guard let other = other as? Self else { return false }
        return self == other
    }
}

public extension Collection {
    
    public func elementsSelflessEqual<C>(_ other: C) -> Bool
        where
        C: Collection,
        C.IndexDistance == IndexDistance
    {
        guard other.count == count else {
            return false
        }
        return zip(self, other).all{ l, r in
            guard
                let l = l as? SelflessEquatable,
                let r = r as? SelflessEquatable
                else
            {
                return false
            }
            return l.isSelflessEqual(to: r)
        }
    }
}
