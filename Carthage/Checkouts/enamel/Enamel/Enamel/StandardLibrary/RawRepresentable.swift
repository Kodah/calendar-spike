//
//  RawRepresentable.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 09/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension RawRepresentable {
    
    /// Allows for e.g. `(0...10).flatMap(Ints.init)`
    /// where `enum Ints: Int { case zero, one, two, three }`
    public init?(_ value: RawValue) {
        self.init(rawValue: value)
    }
}

public extension RawRepresentable where RawValue == String {
    public var string: String { return rawValue }
}

public extension RawRepresentable where RawValue == Bool {
    public var bool: Bool { return rawValue }
}

public extension RawRepresentable where RawValue == Int {
    public var int: Int { return rawValue }
}

public extension RawRepresentable where RawValue == Double {
    public var double: Double { return rawValue }
}

/**
 Adds comparison operator for all `RawRepresentable`s where
 the `RawValue is Comparable`
 
 - note: There's no generic way to add conformance to `Comparable` 
 for all `RawRepresentabes`, so just add the conformance yourself 
 to your type. Once you add conformace you get all comparison
 operators for free.
 */
public func < <R: RawRepresentable>(lhs: R, rhs: R) -> Bool
    where R.RawValue: Comparable
{
    return lhs.rawValue < rhs.rawValue
}
