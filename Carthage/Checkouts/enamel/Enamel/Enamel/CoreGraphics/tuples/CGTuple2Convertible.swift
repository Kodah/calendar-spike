import CoreGraphics

public protocol CGTuple2Convertible {
    var tuple: CGTuple2 { get }
    init(_: CGTuple2)
}

extension CGTuple2Convertible {
    
    public var array: [CGFloat] {
        let tuple = self.tuple
        return [tuple.0, tuple.1]
    }
    
    public func map(_ f: (CGFloat) -> CGFloat) -> Self {
        let (t0, t1) = tuple
        return Self((f(t0), f(t1)))
    }
    
    public func map(_ f: @escaping (CGFloat, CGFloat) -> CGFloat) -> (CGFloat) -> Self {
        let (t0, t1) = tuple
        return { Self((f(t0, $0), f(t1, $0))) }
    }
}

extension CGTuple2Convertible {
    
    public var isNormal: Bool { return array.all{ $0.isNormal } }
    public var isOK: Bool { return array.all{ $0.isOK } }
    public var ifOK: Self? { return isOK ? self : nil }
}

extension CGTuple2Convertible {
    
    public var round: Self { return map(CoreGraphics.round) }
    public var floor: Self { return map(CoreGraphics.floor) }
    public var ceil: Self { return map(CoreGraphics.ceil) }
    public var abs: Self { return map(Swift.abs) }
}

public prefix func - <T: CGTuple2Convertible>(t: T) -> T {
    return t.map(-)
}

// MARK:- CGTuple2Convertible op CGFloat

public func + <T: CGTuple2Convertible>(lhs: T, rhs: CGFloat) -> T {
    return T(lhs.tuple + rhs)
}

public func - <T: CGTuple2Convertible>(lhs: T, rhs: CGFloat) -> T {
    return T(lhs.tuple - rhs)
}

public func * <T: CGTuple2Convertible>(lhs: T, rhs: CGFloat) -> T {
    return T(lhs.tuple * rhs)
}

public func / <T: CGTuple2Convertible>(lhs: T, rhs: CGFloat) -> T {
    return T(lhs.tuple / rhs)
}

// MARK:- CGTuple2Convertible op CGTuple2

public func + <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2) -> T {
    return T(lhs.tuple + rhs)
}

public func - <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2) -> T {
    return T(lhs.tuple - rhs)
}

public func * <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2) -> T {
    return T(lhs.tuple * rhs)
}

public func / <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2) -> T {
    return T(lhs.tuple / rhs)
}

// MARK:- CGTuple2Convertible op CGTuple2Convertible

public func + <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2Convertible) -> T {
    return T(lhs.tuple + rhs.tuple)
}

public func - <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2Convertible) -> T {
    return T(lhs.tuple - rhs.tuple)
}

public func * <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2Convertible) -> T {
    return T(lhs.tuple * rhs.tuple)
}

public func / <T: CGTuple2Convertible>(lhs: T, rhs: CGTuple2Convertible) -> T {
    return T(lhs.tuple / rhs.tuple)
}
