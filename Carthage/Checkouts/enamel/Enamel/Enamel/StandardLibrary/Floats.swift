//
//  FloatingPointNumbers.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 28/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension FloatingPointSign {
    
    public var unit: Int {
        switch self {
        case .minus: return -1
        case .plus: return 1
        }
    }
}

public extension FloatingPoint {
    
    public var ifOK: Self? { return isOK ? self : nil }
    
    public var isOK: Bool { return isNormal || isZero }
    
    public var isRound: Bool { return remainder(dividingBy: 1).isZero }
}

extension Sequence where Iterator.Element: FloatingPoint {
    
    public func sum() -> Iterator.Element {
        return reduce(0, +)
    }
    
    public func product() -> Iterator.Element {
        return reduce(1, *)
    }
}
