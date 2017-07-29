//
//  CGPolygon.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 11/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct CGPolygon {
    
    public var open: Bool
    public var vertices: [CGPoint]
    
    public init(vertices: [CGPoint], open: Bool = false) {
        self.open = open
        self.vertices = vertices
    }
}

extension CGPolygon {
    
    public static func radius(givenSideLength sideLength: CGFloat, count: Int) -> CGFloat {
        switch count
        {
        case 2:
            return sideLength
            
        case 3...Int.max:
            let θ = 1.rotations / count.cg
            return sideLength / θ.sin
            
        default:
            return 0
        }
    }
    
    public init(count: Int, center: CGPoint = .zero, sideLength: CGFloat, startingFrom angle: CGAngle = .zero) {
        open = false
        switch count
        {
        case 1:
            vertices = [center]
            
        case 2...Int.max:
            let radius = CGPolygon.radius(givenSideLength: sideLength, count: count)
            vertices = CGCircle(center: center, radius: radius) 
                .points(count: count, startingFrom: angle)
            
        default:
            vertices = []
        }
    }
    
    public init(count: Int, center: CGPoint = .zero, radius: CGFloat, startingFrom angle: CGAngle = .zero) {
        open = false
        switch count
        {
        case 1:
            vertices = [center]
            
        case 2...Int.max:
            vertices = CGCircle(center: center, radius: radius)
                .points(count: count, startingFrom: angle)
            
        default:
            vertices = []
        }
    }
}

public extension CGPolygon {
    
    public var closed: Bool { return !open }
    
    public var length: CGFloat {
        var points = vertices
        if closed, let point = vertices.first { points.append(point) }
        return zip(vertices.dropFirst(), points)
            .lazy
            .map(CGLine.init)
            .map{ $0.length }
            .reduce(0, +)
    }
}

// MARK:- Conformances

extension CGPolygon: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: CGPoint...) {
        self.init(vertices: elements)
    }
}

extension CGPolygon: SVG {
    public func add(to context: SVGContext) {
        guard var point = vertices.first else { return }
        context.move(to: point)
        for next in vertices.dropFirst() where next != point {
            point = next
            context.line(to: point)
        }
        if closed { context.close() }
    }
}

extension CGPolygon: Equatable {}
public func == (lhs: CGPolygon, rhs: CGPolygon) -> Bool {
    return lhs.vertices == rhs.vertices
}

extension CGPolygon: CustomStringConvertible {
    public var description: String {
        return "CGPolygon(open: \(open), vertices: \(vertices))"
    }
}
