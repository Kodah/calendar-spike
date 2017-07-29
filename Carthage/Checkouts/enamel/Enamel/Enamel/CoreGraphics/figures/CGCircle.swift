//
//  CGCircle.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import CoreGraphics

public struct CGCircle {
    
    public var center: CGPoint
    public var radius: CGFloat
    
    public init(center: CGPoint = .zero, radius: CGFloat) {
        self.center = center
        self.radius = radius
    }
}

// MARK:- .with...

public extension CGCircle {
    
    public func with(center: CGPoint? = nil, radius: CGFloat? = nil) -> CGCircle {
        return CGCircle(center: center ?? self.center, radius: radius ?? self.radius)
    }
}

// MARK:- Static Constants

public extension CGCircle {
    
    public static let zero = CGCircle(center: .zero, radius: .zero)
    public static let unit = CGCircle(center: .zero, radius: .unit)
}

// MARK:- Computed Properties

public extension CGCircle {
    
    public var diameter: CGFloat { return radius * 2 }
    public var size: CGSize { return CGSize(square: diameter) }
    public var frame: CGRect { return CGRect(center: center, size: size) }
}

public extension CGCircle {
    
    public var inscribedSquare: CGRect {
        return CGRect(center: center, size: CGSize(square: diameter * sqrt0_5))
    }
    
    public func inscribedRect(withAspectRatioOf: CGSize) -> CGRect {
        return inscribedRect(withAspectRatio: withAspectRatioOf.aspectRatio ?? .nan)
    }
    
    public func inscribedRect(withAspectRatio aspectRatio: CGFloat) -> CGRect {
        guard aspectRatio.isNormal else {
            return CGRect(center: center, size: .zero)
        }
        let θ = atan2(aspectRatio, 1)
        let size = CGSize(
            width: sin(θ) * radius * 2,
            height: cos(θ) * radius * 2
        )
        return size.rect(center: center)
    }
}

// MARK:- Creators

public extension CGCircle {
    
    public func scaled(by scale: CGFloat) -> CGCircle {
        return CGCircle(center: center, radius: radius * scale)
    }
    
    public func resized(by dr: CGFloat) -> CGCircle {
        return CGCircle(center: center, radius: radius + dr)
    }
}

// MARK:- Non-Mutating Methods

public extension CGCircle {
    
    public func point(atAngle angle: CGAngle) -> CGPoint {
        return center.offsetBy(angle: angle, distance: radius)
    }
    
    public func points(count: Int, startingFrom angle: CGAngle = .zero) -> [CGPoint] {
        guard count > 0 else { return [] }
        return (0..<count).map{
            point(atAngle: (angle + ($0.cg / count.cg).rotations))
        }
    }
}

// MARK:- Conformances

extension CGCircle: SVG {
    public func add(to context: SVGContext) {
        context.circle(at: center, radius: radius)
    }
}

extension CGCircle: Equatable {}
public func == (lhs: CGCircle, rhs: CGCircle) -> Bool {
    return lhs.radius == rhs.radius
        && lhs.center == rhs.center
}

extension CGCircle: CustomStringConvertible {
    public var description: String {
        return "CGCircle(center: \(center), radius: \(radius))"
    }
}

// MARK:- Utils

private let sqrt0_5 = sqrt(0.5.cg)
