
// MARK:- Sequence

public extension Sequence {
    public var array: [Iterator.Element] { return Array(self) }
}

public extension Sequence where Iterator.Element : Hashable {
    public var set: Set<Iterator.Element> { return Set(self) }
}

public extension Sequence {
    
    public func all(_ predicate: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for e in self where try !predicate(e) { return false }
        return true
    }
    
    public func none(_ predicate: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        for e in self where try predicate(e) { return false }
        return true
    }
    
    /// Synonymous to `contains`
    public func any(_ predicate: (Iterator.Element) throws -> Bool) rethrows -> Bool {
        return try contains(where: predicate)
    }
}

public extension Sequence {
    
    public func all<T>(_ type: T.Type) -> Bool {
        for e in self where !(e is T) { return false }
        return true
    }
    
    public func none<T>(_ type: T.Type) -> Bool {
        for e in self where e is T { return false }
        return true
    }
    
    /// Synonymous to `contains`
    public func any<T>(_ type: T.Type) -> Bool {
        for e in self where e is T { return true }
        return false
    }
    
    /// Synonymous to `any`
    public func contains<T>(_ type: T.Type) -> Bool {
        for e in self where e is T { return true }
        return false
    }
    
    public func count(if predicate: (Iterator.Element) -> Bool) -> Int {
        return self.reduce(0){ $0 + (predicate($1) ? 1 : 0) }
    }
}

public extension Sequence {
    
    public func filterInOut(_ isIn: (Iterator.Element) throws -> Bool) rethrows -> (in: [Iterator.Element], out: [Iterator.Element]) {
        return try (filter(isIn), filter{ try !isIn($0) }) // TODO: improve performance
    }
}

public extension Sequence {
    
    public func filter<T>(_ type: T.Type) -> [T] {
        return flatMap{ $0 as? T }
    }
}

public extension Sequence {
    
    public func reduce(_ combine: (Iterator.Element, Iterator.Element) throws -> Iterator.Element) rethrows -> Iterator.Element? {
        var it = makeIterator()
        guard var o = it.next() else { return nil }
        while let next = it.next() { o = try combine(o, next) }
        return o
    }
    
    public func reduce<Result>(_ initial: Result, _ combine: (Result) -> (Iterator.Element) -> Result) -> Result {
        return reduce(initial){ combine($0)($1) }
    }
    
    public func reduce(_ combine: (Iterator.Element) -> (Iterator.Element) -> Iterator.Element) -> Iterator.Element? {
        return reduce{ combine($0)($1) }
    }
}

public extension Sequence {
    
    public func forEach<Ignore>(_ body: (Iterator.Element) -> () -> (Ignore)) {
        forEach{ _ = body($0)() }
    }
}

public extension Sequence {
    
    public func sorted<Property>(by property: @escaping (Iterator.Element) -> Property) -> ((Property, Property) -> Bool) -> [Iterator.Element] {
        return { areInIncreasingOrder in
            return self.sorted{ lhs, rhs in areInIncreasingOrder(property(lhs), property(rhs)) }
        }
    }
    
    @warn_unqualified_access
    public func min<Property>(by property: @escaping (Iterator.Element) -> Property) -> ((Property, Property) -> Bool) -> Iterator.Element? {
        return { areInIncreasingOrder in
            return self.min{ lhs, rhs in areInIncreasingOrder(property(lhs), property(rhs)) }
        }
    }
    
    @warn_unqualified_access
    public func max<Property>(by property: @escaping (Iterator.Element) -> Property) -> ((Property, Property) -> Bool) -> Iterator.Element? {
        return { areInIncreasingOrder in
            return self.max{ lhs, rhs in areInIncreasingOrder(property(lhs), property(rhs)) }
        }
    }
}

// MARK:- Collection

public extension Collection {
    
    public var isNotEmpty: Bool { return !isEmpty }
}

public extension Collection {
    
    public func first<T>(_ type: T.Type) -> T? {
        return first{ $0 is T } as? T
    }
    
    public func index<T>(of type: T.Type) -> Index?  {
        return index{ $0 is T }
    }
}

public extension Collection where Indices: RandomAccessCollection, Indices.Iterator.Element == Index {
    
    public subscript(index: Index, else defaultValue: @autoclosure () -> Iterator.Element) -> Iterator.Element {
        return at(index) ?? defaultValue()
    }
    
    public func at(_ index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

public extension Collection where Index == Int, IndexDistance == Int, Indices.Iterator.Element == Index {

    /**
     - note: This was a quick attempt to come up with anything more performant than 
     calling `contains` on each element of both collections.
     */
    public func diff<C>(from other: C, areEqual: (Iterator.Element, Iterator.Element) -> Bool)
        -> (enter: [Iterator.Element], exit: [Iterator.Element])
        where
        C: Collection,
        C.Index == Int,
        C.IndexDistance == Int,
        C.Indices.Iterator.Element == C.Index,
        C.Iterator.Element == Iterator.Element
    {
        var diffFrom: [Bool?] = Array(repeating: nil, count: other.count)
        var diffTo: [Bool?] = Array(repeating: nil, count: self.count)
        var sharedCount = 0
        for i in other.indices {
            if let j = self.index(where: { areEqual(other[i], $0) }) {
                diffFrom[i] = true
                diffTo[j] = true
                sharedCount += 1
            } else {
                diffFrom[i] = false
            }
        }
        if sharedCount > 0 {
            for i in self.indices where diffTo[i] == nil {
                for j in other.indices where diffFrom[j] ?? false {
                    diffTo[i] = areEqual(self[i], other[j])
                }
            }
        }
        let enter = zip(diffTo, self).flatMap{ !($0 ?? false) ? $1 : nil }
        let exit = zip(diffFrom, other).flatMap{ !($0 ?? false) ? $1 : nil }
        return (enter, exit)
    }
}

public extension Collection where Iterator.Element: Equatable, Index == Int, IndexDistance == Int, Indices.Iterator.Element == Index {
    
    /**
     - note: This was a quick attempt to come up with anything more performant than
     calling `contains` on each element of both collections.
     */
    public func diff<C>(from other: C)
        -> (enter: [Iterator.Element], exit: [Iterator.Element])
        where
        C: Collection,
        C.Index == Int,
        C.IndexDistance == Int,
        C.Indices.Iterator.Element == C.Index,
        C.Iterator.Element == Iterator.Element
    {
        return diff(from: other, areEqual: ==)
    }
}

// MARK:- BidirectionalCollection

public extension BidirectionalCollection {
    
    public func last<T>(_ type: T.Type) -> T? {
        return last{ $0 is T } as? T
    }
    
    public func last(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Iterator.Element? {
        return try reversed().first(where: predicate)
    }
}

public extension BidirectionalCollection where Indices: BidirectionalCollection, Indices.Iterator.Element == Index {
    
    public func lastIndex<T>(of type: T.Type) -> Index? {
        return lastIndex{ $0 is T }
    }
    
    public func lastIndex(where predicate: (Iterator.Element) throws -> Bool) rethrows -> Index? {
        return try zip(indices.reversed(), reversed()).first{ try predicate($0.1) }?.0
    }
}

// MARK:- RangeReplaceableCollection

public extension RangeReplaceableCollection {
    
    public static func += (lhs: inout Self, rhs: Iterator.Element) {
        lhs.append(rhs)
    }
    
    public static func += <S>(lhs: inout Self, rhs: S)
        where S: Sequence, S.Iterator.Element == Iterator.Element
    {
        lhs.append(contentsOf: rhs)
    }
    
    public static func + (lhs: Self, rhs: Iterator.Element) -> Self {
        var lhs = lhs
        lhs.append(rhs)
        return lhs
    }
    
    public static func + <S>(lhs: inout Self, rhs: S) -> Self
        where S: Sequence, S.Iterator.Element == Iterator.Element
    {
        var lhs = lhs
        lhs.append(contentsOf: rhs)
        return lhs
    }
}

extension RangeReplaceableCollection {
    
    /// Synonymous to `append(_:ifNone:)`
    public mutating func append(_ element: Iterator.Element, unlessAny predicate: (Iterator.Element) throws -> Bool) rethrows {
        if try none(predicate) { append(element) }
    }
    
    /// Synonymous to `append(_:unlessAny:)`
    public mutating func append(_ element: Iterator.Element, ifNone predicate: (Iterator.Element) throws -> Bool) rethrows {
        if try none(predicate) { append(element) }
    }
    
    public mutating func removeEach(_ predicate: (Iterator.Element) throws -> Bool) rethrows {
        try withoutActuallyEscaping(predicate) { predicate in
            self.replaceSubrange(self.startIndex..<self.endIndex, with: try self.filter(not(predicate)))
        }
    }
}

// MARK:- Array

public func == <T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs)
    {
    case let (.some(lhs), .some(rhs)):
        return lhs == rhs
        
    case (.none, .none):
        return true
        
    default:
        return false
    }
}

// MARK:- Set

extension Set {
    
    public func doesNotContain(_ member: Element) -> Bool {
        return !contains(member)
    }
}

