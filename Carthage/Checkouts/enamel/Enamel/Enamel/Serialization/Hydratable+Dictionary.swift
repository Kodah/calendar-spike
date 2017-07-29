//
//  Hydratable+Dictionary.swift
//  Enamel
//
//  Created by Jon Cotton & Milos Rankovic on 05/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension Dictionary {
    
    public func hydrate<T>(_ key: Key) throws -> T {
        guard let $ = self[key] as? T else {
            throw HydratingError(type: T.self, key: key, data: self)
        }
        return $
    }
    
    public func hydrate<T>(_ key: Key, else defaultValue: @autoclosure () -> T) -> T {
        guard let $ = self[key] as? T else {
            return defaultValue()
        }
        return $
    }
    
    public func hydrate<T: Hydratable>(_ key: Key) throws -> T {
        let o = self[key]
        if let o = o as? [String:Any] {
            return try T(source: o)
        } else if let t = o as? T {
            return t
        } else {
            throw HydratingError(type: T.self, key: key, data: self)
        }
    }
    
    public func hydrate<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> T) -> T {
        return (try? hydrate(key)) ?? defaultValue()
    }
    
    public func hydrate<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> T?) -> T? {
        return (try? hydrate(key) as T) ?? defaultValue()
    }
}

// MARK:- hydrateEach

public extension Dictionary {
    
    // MARK:- hydrate/hydrateEach synonims:
    
    public func hydrate<T: Hydratable>(_ key: Key) throws -> [T] {
        return try hydrateEach(key)
    }
    
    public func hydrate<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> [T]) -> [T] {
        return hydrateEach(key, else: defaultValue)
    }
    
    public func hydrateEach<T>(_ key: Key) throws -> [T] {
        return try hydrate(key)
    }
    
    public func hydrateEach<T>(_ key: Key, else defaultValue: @autoclosure () -> [T]) throws -> [T] {
        return (try? hydrate(key)) ?? defaultValue()
    }
    
    // MARK:- hydrateEach implementations where T: Hydratable:
    
    // FIXME: rename to `hydrateAll` so that `hydrateEach("frogs")` reads better
    public func hydrateEach<T: Hydratable>(_ key: Key) throws -> [T] {
        let o = self[key]
        if let o = o as? [[String:Any]] {
            return try o.map{ try T(source: $0) }
        } else if let t = o as? [T] {
            return t
        } else {
            throw HydratingError(type: [T].self, key: key, data: self)
        }
    }
    
    public func hydrateEach<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> [T]) -> [T] {
        return (try? hydrateEach(key)) ?? defaultValue()
    }
    
    // optional arrays
    
    public func hydrateEach<T: Hydratable>(_ key: Key, else defaultValue: [T]?) -> [T]? {
        do {
            let $: [T] = try hydrateEach(key)
            return $
        } catch {
            return defaultValue
        }
    }
}

// MARK:- hydrateAny

public extension Dictionary {
    
    // TODO: Make a more general hydrateWhen/If that uses a predicate closure to decide when to map
  
    public func hydrateAny<T>(_ key: Key) throws -> [T] {
        guard let array = self[key] as? [Value] else {
            throw HydratingError(type: [T].self, key: key, data: self)
        }
        return array.flatMap{ $0 as? T }
    }
    
    public func hydrateAny<T>(_ key: Key, else defaultValue: @autoclosure () -> [T]) -> [T] {
        return (try? hydrateAny(key)) ?? defaultValue()
    }
    
    public func hydrateAny<T: Hydratable>(_ key: Key) throws -> [T] {
        let o = self[key]
        if let o = o as? [[String:Any]] {
            return o.flatMap{
                do {
                    return try T(source: $0)
                } catch {
                    note(error)
                    return nil
                }
            }
        } else if let t = o as? [T] {
            return t
        } else {
            throw HydratingError(type: [T].self, key: key, data: self)
        }
    }
    
    public func hydrateAny<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> [T]) -> [T] {
        return (try? hydrateAny(key)) ?? defaultValue()
    }
    
    public func hydrateAny<T: Hydratable>(_ key: Key, else defaultValue: @autoclosure () -> [T]?) -> [T]? {
        do {
            return try hydrateAny(key)
        } catch {
            return defaultValue()
        }
    }
}

// MARK:- Transforms

public extension Dictionary {
    
    public func hydrate<T, U>(_ key: Key, transform: (U) -> T?) throws -> T {
        guard let u = self[key] as? U, let t = transform(u) else {
            throw HydratingError(type: T.self, key: key, data: self)
        }
        return t
    }
    
    public func hydrate<T, U>(_ key: Key, transform: (U) -> T?) throws -> [T] {
        let us = try hydrate(key) as [U]
        return try us.map{
            guard let o = transform($0) else {
                throw HydratingError(
                    info: "Failed to map \($0) to \(T.self)",
                    type: [T].self,
                    key: key,
                    data: self
                )
            }
            return o
        }
    }
    
    public func hydrate<T, U>(_ key: Key, else defaultValue: @autoclosure () -> T, transform: (U) -> T?) -> T {
        guard let u = self[key] as? U, let t = transform(u) else {
            return defaultValue()
        }
        return t
    }
    
    public func hydrate<T, U>(_ key: Key, else defaultValue: @autoclosure () -> [T], transform: (U) -> T?) throws -> [T] {
        return (try? hydrate(key, transform: transform)) ?? defaultValue()
    }
    
    public func hydrate<T: Hydratable, U>(_ key: Key, else defaultValue: @autoclosure () -> T, transform: (U) -> T?) -> T {
        return (try? hydrate(key) as U).flatMap(transform) ?? defaultValue()
    }
    
    public func hydrate<T: Hydratable, U>(_ key: Key, transform: (U) -> T?) throws -> [T] {
        return try hydrateEach(key, transform: transform)
    }
    
    public func hydrateEach<T: Hydratable, U>(_ key: Key, transform: (U) -> T?) throws -> [T] {
        let us: [U] = try self.hydrateEach(key)
        return try us.map {
            guard let u = transform($0) else {
                throw HydratingError(type: T.self, key: key, data: self)
            }
            return u
        }
    }
    
    public func hydrateAny<T, U>(_ key: Key, transform: (U) -> T?) throws -> [T] {
        let us: [U] = try self.hydrateAny(key)
        return us.flatMap(transform)
    }
    
    public func hydrateAny<T, U>(_ key: Key, else defaultValue: @autoclosure () -> [T], transform: (U) -> T?) -> [T] {
        return (try? self.hydrateAny(key, transform: transform)) ?? defaultValue()
    }

    public func hydrateAny<T: Hydratable, U>(_ key: Key, transform: (U) -> T?) throws -> [T] {
        let us: [U] = try self.hydrateAny(key)
        return us.flatMap(transform)
    }
    
    public func hydrateAny<T: Hydratable, U>(_ key: Key, else defaultValue: @autoclosure () -> [T], transform: (U) -> T?) -> [T] {
        return (try? hydrateAny(key, transform: transform)) ?? defaultValue()
    }
}


