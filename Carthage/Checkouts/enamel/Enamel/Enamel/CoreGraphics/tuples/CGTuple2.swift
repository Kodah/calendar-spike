import CoreGraphics

public typealias CGTuple2 = (CGFloat, CGFloat)

// MARK:- CGTuple2 op CGFloat

public func + (lhs: CGTuple2, rhs: CGFloat) -> CGTuple2 {
    return (lhs.0 + rhs, lhs.1 + rhs)
}

public func - (lhs: CGTuple2, rhs: CGFloat) -> CGTuple2 {
    return (lhs.0 - rhs, lhs.1 - rhs)
}

public func * (lhs: CGTuple2, rhs: CGFloat) -> CGTuple2 {
    return (lhs.0 * rhs, lhs.1 * rhs)
}

public func / (lhs: CGTuple2, rhs: CGFloat) -> CGTuple2 {
    return (lhs.0 / rhs, lhs.1 / rhs)
}

// MARK:- CGTuple2 op CGTuple2

public func + (lhs: CGTuple2, rhs: CGTuple2) -> CGTuple2 {
    return (lhs.0 + rhs.0, lhs.1 + rhs.1)
}

public func - (lhs: CGTuple2, rhs: CGTuple2) -> CGTuple2 {
    return (lhs.0 - rhs.0, lhs.1 - rhs.1)
}

public func * (lhs: CGTuple2, rhs: CGTuple2) -> CGTuple2 {
    return (lhs.0 * rhs.0, lhs.1 * rhs.1)
}

public func / (lhs: CGTuple2, rhs: CGTuple2) -> CGTuple2 {
    return (lhs.0 / rhs.0, lhs.1 / rhs.1)
}


