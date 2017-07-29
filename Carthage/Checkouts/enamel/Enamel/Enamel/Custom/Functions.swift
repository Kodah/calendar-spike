//
//  Functions.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 25/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- apply

public func § <A,B>(lhs: (A) throws -> B, rhs: A) rethrows -> B {
    return try lhs(rhs)
}

// MARK:- pipe forward

public func |> <A,B>(lhs: A, rhs: (A) throws -> B) rethrows -> B {
    return try rhs(lhs)
}

public func |>> <S,A,B>(lhs: S, rhs: (A) throws -> B) rethrows -> [B]
    where
    S: Sequence,
    S.Iterator.Element == A
{
    return try lhs.map(rhs)
}

// MARK:- Never

public var NEVER: Never { fatalError() }
public var IMPOSSIBLE: Never { NEVER }
public var UNIMPLEMENTED: Never { NEVER }

#if DEBUG
    public var TODO: Never { NEVER }
    public func warning(_: Never = NEVER) {}
#endif

// MARK:- not

public func not(_ bool: Bool) -> Bool { return !bool }

public func not<T>(_ predicate: @escaping (T) -> Bool) -> (T) -> Bool {
    return { !predicate($0) }
}

public func not<T>(_ predicate: @escaping (T) throws -> Bool) -> (T) throws -> Bool {
    return { try !predicate($0) }
}

public func not<T, U>(_ predicate: @escaping (T, U) -> Bool) -> (T, U) -> Bool {
    return { !predicate($0, $1) }
}

public func not<T, U>(_ predicate: @escaping (T, U) throws -> Bool) -> (T, U) throws -> Bool {
    return { try !predicate($0, $1) }
}

// MARK:- with

@discardableResult
public func with<T>(_ t: T, _ f: (T) throws -> ()) rethrows -> T {
    try f(t)
    return t
}

// MARK:- flip

public func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    return { b, a in f(a, b) }
}

public func flip<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (C, B, A) -> D {
    return { c, b, a in f(a, b, c) }
}

// MARK:- Curry

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

public func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) } } }
}

// MARK:- Playgrounds

/**
 Used by `example(_:code:)`
*/
public var playgroundExampleHeadingIndent = "............................"

/**
 Playground convenience function
*/
public func example<PrintMe>(_ name: String, code: () throws -> PrintMe) {
    print(playgroundExampleHeadingIndent, name)
    do {
        let printMe = try code()
        if !(printMe is Void) { 
            print(printMe)
        }
    } catch {
        print(error)
    }
    print()
}
