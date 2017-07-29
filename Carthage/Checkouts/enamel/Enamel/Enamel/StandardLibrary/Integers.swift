//
//  Int.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 03/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

// MARK:- UnsignedInteger

public extension UnsignedInteger {
    
    public static var max: Self { return ~0 }
}

extension Sequence where Iterator.Element: IntegerArithmetic & ExpressibleByIntegerLiteral {
    
    public func sum() -> Iterator.Element {
        return reduce(0, +)
    }
    
    public func product() -> Iterator.Element {
        return reduce(1, *)
    }
}

// MARK:- UIntMax

public extension UIntMax {
    
    public var plusMinIntMax: IntMax {
        if self > UIntMax(IntMax.max) {
            return IntMax(self - UIntMax(IntMax.max) - 1)
        }
        else { return IntMax.min + IntMax(self) }
    }
}

// MARK:- SignedInteger

public extension SignedInteger {
    
    public func unsignedDistanceTo(_ other: Self) -> UIntMax {
        let _self = self.toIntMax()
        let other = other.toIntMax()
        let (start, end) = _self < other ? (_self, other) : (other, _self)
        if start == IntMax.min && end == IntMax.max {
            return UIntMax.max
        }
        if start < 0 && end >= 0 {
            let s = start == IntMax.min ? UIntMax(Int.max) + 1 : UIntMax(-start)
            return s + UIntMax(end)
        }
        return UIntMax(end - start)
    }
    
    public var unsignedDistanceFromMin: UIntMax {
        return IntMax.min.unsignedDistanceTo(self.toIntMax())
    }
}

public extension Collection where Iterator.Element: SignedInteger {
    
    public var sum: Iterator.Element { return reduce(0, +) }
    public var product: Iterator.Element { return reduce(1, *) }
}

// MARK:- Int

/// "Divisible by" operator
/// - parameter lhs: whole number
/// - parameter rhs: candidate factor of `lhs`
public func %== (lhs: Int, rhs: Int) -> Bool {
    return lhs % rhs == 0
}

/// "Divisible by" operator
/// - parameter lhs: whole number
/// - parameter rhs: candidate factors of `lhs`
public func %== <Ints: Sequence>(lhs: Int, rhs: Ints) -> Bool
    where Ints.Iterator.Element == Int
{
    return rhs.all{ lhs % $0 == 0 }
}

public extension Int {
    public var isEven: Bool { return self % 2 == 0 }
    public var isOdd: Bool { return self % 2 != 0 }
}

public extension Int {
    
    /// - note: If you need `index` passed in use `(from...to).forEach(_:)` instead
    public func times<Ignored>(do closure: () -> Ignored) {
        (0..<self).forEach{ _ in _ = closure() }
    }
    
    /// - note: If you need `index` passed in use `(from...to).map(_:)` instead
    public func of<T>(_ make: () -> T) -> [T] {
        return (0..<self).map{ _ in make() }
    }
}
