//
//  CGContext.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 09/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- Graphics state methods

public extension CGContext {
    
    public func temp(_ closure: (CGContext) -> ()) -> CGContext {
        self.saveGState()
        closure(self)
        self.restoreGState()
        return self
    }
}

// MARK:- Bitmap Creation

public extension CGContext {
    
    public var image: CGImage? { return makeImage() }
    public var size: CGSize { return CGSize(width: width, height: height) }
    
    public static func rgb(width: UInt, height: UInt, color: CGColor? = nil) -> CGContext? {
        let c = CGContext(
            data: nil,
            width: Int(width),
            height: Int(height),
            bitsPerComponent: 8,
            bytesPerRow: 0,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
        )
        if let c = c, let color = color {
            _ = c.temp{ o in
                o.setFillColor(color)
                o.fill(c.size.rect())
            }
        }
        return c
    }
}

// MARK:- mutating

public extension CGContext {
    
    public func translate(by t: CGTuple2Convertible) -> CGContext {
        let (dx, dy) = t.tuple
        return translateBy(dx: dx, dy: dy)
    }
    
    public func translateBy(dx: CGFloat = 0, dy: CGFloat = 0) -> CGContext {
        translateBy(x: dx, y: dy)
        return self
    }
}


// MARK:- SVGContext

extension CGContext: SVGContext {
    
    public func close() -> Self {
        closePath()
        return self
    }
    
    public func move(to point: CGPoint) -> Self {
        move(to: point) as Void
        return self
    }
    
    public func line(to point: CGPoint) -> Self {
        addLine(to: point)
        return self
    }
    
    public func arc(at center: CGPoint, radius: CGFloat, startAngle: CGAngle, endAngle: CGAngle) -> Self {
        addArc(
            center: center,
            radius: radius,
            startAngle: startAngle.inRadians,
            endAngle: endAngle.inRadians,
            clockwise: CGGeometry.isClockwiseTurn(from: startAngle, to: endAngle)
        )
        return self
    }
    
    public func ellipse(at center: CGPoint, xRadius: CGFloat, yRadius: CGFloat) -> Self {
        let rect = CGRect(
            center: center,
            size: CGSize(width: xRadius * 2, height: yRadius * 2)
        )
        addEllipse(in: rect)
        return self
    }
    
    public func circle(at center: CGPoint, radius: CGFloat) -> Self {
        let rect = CGRect(
            center: center,
            size: CGSize(square: radius * 2)
        )
        addEllipse(in: rect)
        return self
    }
    
    public func rectangle(_ rect: CGRect) -> Self {
        addRect(rect)
        return self
    }
}

#if os(iOS)
    import UIKit
    
    public extension CGImage {
        public var ui: UIImage? { return UIImage(cgImage: self) }
    }
    
    extension CGContext: CustomPlaygroundQuickLookable {
        
        public var customPlaygroundQuickLook: PlaygroundQuickLook {
            guard let image = image?.ui else {
                return .text("CGContext")
            }
            return .image(image)
        }
    }
#endif
