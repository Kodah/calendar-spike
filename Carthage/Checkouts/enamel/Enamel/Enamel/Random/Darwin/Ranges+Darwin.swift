//
//  Range+Darwin.swift
//  Enamel
//
//  Created by Milos Rankovic on 11/04/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Darwin

public extension ClosedRange where Bound: UnsignedInteger {
    
    public var random: Bound {
        guard lowerBound > 0 || upperBound < Bound.max else { return Bound.random }
        return lowerBound + (Bound.random % (upperBound - lowerBound + 1))
    }
}

public extension ClosedRange where Bound: SignedInteger {
    
    public var random: Bound {
        let foot = MemoryLayout<Bound>.size
        guard foot > 4 else {
            let off = UInt32.random % UInt32(numericCast(upperBound) - numericCast(lowerBound) + 1)
            return numericCast(lowerBound.toIntMax() + off.toIntMax())
        }
        let distance = lowerBound.unsignedDistanceTo(upperBound)
        guard distance < UIntMax.max else {
            return numericCast(IntMax(bitPattern: UIntMax.random))
        }
        let off = UIntMax.random % (distance + 1)
        let x = (off + lowerBound.unsignedDistanceFromMin).plusMinIntMax
        return numericCast(x)
    }
}

public extension CountableClosedRange {
    
    public var sample: Element {
        let off = (0...(count.advanced(by: -1))).random
        let idx = index(startIndex, offsetBy: off)
        return self[idx]
    }
}

public extension CountableRange {
    
    public var sample: Element? {
        guard isNotEmpty else { return nil }
        let closed = startIndex...index(before: endIndex)
        return closed.sample
    }
}
