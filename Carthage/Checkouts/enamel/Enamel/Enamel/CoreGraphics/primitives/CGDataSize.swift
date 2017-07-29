//
//  CGMemorySize.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 18/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension CGFloatConvertible {
    
    public var B: CGDataSize { return .B(cg) }
    
    public var kB: CGDataSize { return .kB(cg) }
    public var MB: CGDataSize { return .MB(cg) }
    public var GB: CGDataSize { return .GB(cg) }
    public var TB: CGDataSize { return .TB(cg) }
    
    public var KiB: CGDataSize { return .KiB(cg) }
    public var MiB: CGDataSize { return .MiB(cg) }
    public var GiB: CGDataSize { return .GiB(cg) }
    public var TiB: CGDataSize { return .TiB(cg) }
}

/// On the distinction between binary and decimal units (e.g. `kB` vs `KiB`),
/// see [wikipedia.org/wiki/Kilobyte](https://en.wikipedia.org/wiki/Kilobyte)
///
public enum CGDataSize {
    
    case B(CGFloat)
    
    case kB(CGFloat)
    case MB(CGFloat)
    case GB(CGFloat)
    case TB(CGFloat)
    
    case KiB(CGFloat)
    case MiB(CGFloat)
    case GiB(CGFloat)
    case TiB(CGFloat)
}

extension CGDataSize {
    public static let zero = 0.B
    public static let unit = 1.B
}

extension CGDataSize: Comparable {
    
    public var B: CGFloat {
        switch self {
        case .B(let $): return $
            
        case .kB(let $): return $ * 1000
        case .MB(let $): return $ * 1000_000
        case .GB(let $): return $ * 1000_000_000
        case .TB(let $): return $ * 1000_000_000_000.0
            
        case .KiB(let $): return $ * 1024
        case .MiB(let $): return $ * 1_048_576
        case .GiB(let $): return $ * 1_073_741_824
        case .TiB(let $): return $ * 1_099_511_627_776.0
        }
    }
    
    public var kB: CGFloat {
        switch self {
        case .B(let $): return $ / 1000
            
        case .kB(let $): return $
        case .MB(let $): return $ * 1000
        case .GB(let $): return $ * 1000_000
        case .TB(let $): return $ * 1000_000_000
            
        case .KiB(let $): return $ * 1.024
        case .MiB(let $): return $ * 1_048.576
        case .GiB(let $): return $ * 1_073_741.824
        case .TiB(let $): return $ * 1_099_511_627.776
        }
    }
    
    public var MB: CGFloat {
        switch self {
        case .B(let $): return $ / 1000_000
            
        case .kB(let $): return $ / 1000
        case .MB(let $): return $
        case .GB(let $): return $ * 1000
        case .TB(let $): return $ * 1000_000
            
        case .KiB(let $): return $ * 0.001_024
        case .MiB(let $): return $ * 1.048_576
        case .GiB(let $): return $ * 1_073.741_824
        case .TiB(let $): return $ * 1_099_511.627_776
        }
    }
    
    public var GB: CGFloat {
        switch self {
        case .B(let $): return $ / 1000_000_000
            
        case .kB(let $): return $ / 1000_000
        case .MB(let $): return $ / 1000
        case .GB(let $): return $
        case .TB(let $): return $ * 1000
            
        case .KiB(let $): return $ * 0.000_001_024
        case .MiB(let $): return $ * 0.001_048_576
        case .GiB(let $): return $ * 1.073_741_824
        case .TiB(let $): return $ * 1_099.511_627_776
        }
    }
    
    public var TB: CGFloat {
        switch self {
        case .B(let $): return $ / 1000_000_000_000.0
            
        case .kB(let $): return $ / 1000_000_000
        case .MB(let $): return $ / 1000_000
        case .GB(let $): return $ / 1000
        case .TB(let $): return $
            
        case .KiB(let $): return $ * 1.024e-9
        case .MiB(let $): return $ * 0.000_001_048_576
        case .GiB(let $): return $ * 0.001_073_741_824
        case .TiB(let $): return $ * 1.099_511_627_776
        }
    }
    
    // TODO: implement per case (more performant)
    public var KiB: CGFloat { return self.B / 1024 }
    public var MiB: CGFloat { return self.B / 1048_576 }
    public var GiB: CGFloat { return self.B / 1_073_741_824 }
    public var TiB: CGFloat { return self.B / 1_099_511_627_776.0 }
}

// MARK:- toString


public extension CGDataSize {
    
    public enum UnitType {
        case decimal
        case binary
    }
    
    public var unitString: String {
        switch self {
        case .B: return "B"
            
        case .kB: return "kB"
        case .MB: return "MB"
        case .GB: return "GB"
        case .TB: return "TB"
            
        case .KiB: return "KiB"
        case .MiB: return "MiB"
        case .GiB: return "GiB"
        case .TiB: return "TiB"
        }
    }
    
    public func toString(using units: UnitType = .decimal, significantPlaces: Int = 2, pivot: CGFloat = 0.1, separator space: String = "") -> String {
        let (value, units) = self.toStrings(using: units, significantPlaces: significantPlaces, pivot: pivot)
        return "\(value)\(space)\(units)"
    }
    
    public func toStrings(using units: UnitType = .decimal, significantPlaces: Int = 2, pivot: CGFloat = 0.1) -> (value: String, units: String) {
        let preferred = self.inPreferredUnits(ofType: units, pivot: pivot)
        let value = preferred.rawValue.round(places: preferred.precision(withSignificantPlaces: significantPlaces)).toString()
        return (value, preferred.unitString)
    }
    
    public func precision(withSignificantPlaces places: Int) -> Int {
        switch self {
        case .B: return 0
        default: return min(places, max(0, places - Int(log10(rawValue.abs).floor)))
        }
    }
    
    public func inPreferredUnits(ofType type: UnitType, pivot: CGFloat = 0.1) -> CGDataSize {
        switch type {
        case .decimal: return inPreferedDecimalUnits(pivot)
        case .binary: return inPreferedBinaryUnits(pivot)
        }
    }
    
    public func inPreferedDecimalUnits(_ pivot: CGFloat) -> CGDataSize {
        let o = abs(self)
        if o < pivot.kB { return self.B.B }
        if o < pivot.MB { return self.kB.kB }
        if o < pivot.GB { return self.MB.MB }
        if o < pivot.TB { return self.GB.GB }
        return self.TB.TB
    }
    
    public func inPreferedBinaryUnits(_ pivot: CGFloat) -> CGDataSize {
        let o = abs(self)
        if o < pivot.KiB { return self.B.B }
        if o < pivot.MiB { return self.KiB.KiB }
        if o < pivot.GiB { return self.MiB.MiB }
        if o < pivot.TiB { return self.GiB.GiB }
        return self.TiB.TiB
    }
}

extension CGDataSize: CustomStringConvertible {
    public var description: String { return toString() }
}

// MARK:- Equatable

public func == (lhs: CGDataSize, rhs: CGDataSize) -> Bool {
    return lhs.rawValue == rhs.rawValue(ofSameTypeAs: lhs)
}

// MARK:- Comparable

public func < (lhs: CGDataSize, rhs: CGDataSize) -> Bool {
    return lhs.rawValue < rhs.rawValue(ofSameTypeAs: lhs)
}

// MARK:- Arithmetic

public func abs(_ size: CGDataSize) -> CGDataSize {
    return .kB(size.kB.abs)
}

public prefix func - (size: CGDataSize) -> CGDataSize {
    return .kB(-size.kB)
}

public func + (lhs: CGDataSize, rhs: CGDataSize) -> CGDataSize {
    return .kB(lhs.kB + rhs.kB)
}

public func - (lhs: CGDataSize, rhs: CGDataSize) -> CGDataSize {
    return .kB(lhs.kB - rhs.kB)
}

public func * (lhs: CGDataSize, rhs: CGFloatConvertible) -> CGDataSize {
    return .kB(lhs.kB * rhs.cg)
}

public func / (lhs: CGDataSize, rhs: CGFloatConvertible) -> CGDataSize {
    return .kB(lhs.kB / rhs.cg)
}

// MARK:- rawValue (private)

private extension CGDataSize {
    
    var rawValue: CGFloat {
        switch self {
        case .B(let $): return $
        case .kB(let $): return $
        case .MB(let $): return $
        case .GB(let $): return $
        case .TB(let $): return $
            
        case .KiB(let $): return $
        case .MiB(let $): return $
        case .GiB(let $): return $
        case .TiB(let $): return $
        }
    }
    
    func rawValue(ofSameTypeAs size: CGDataSize) -> CGFloat {
        switch size {
        case .B: return self.B
        case .kB: return self.kB
        case .MB: return self.MB
        case .GB: return self.GB
        case .TB: return self.TB
            
        case .KiB: return self.KiB
        case .MiB: return self.MiB
        case .GiB: return self.GiB
        case .TiB: return self.TiB
        }
    }
}

