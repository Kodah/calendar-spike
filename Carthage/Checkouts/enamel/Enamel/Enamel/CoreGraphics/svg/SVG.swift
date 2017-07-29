import CoreGraphics

public protocol SVG: CustomPlaygroundQuickLookable {
    func add(to context: SVGContext)
}

public func + <L: SVG, R: SVG>(lhs: L, rhs: R) -> SVGGroup {
    return SVGGroup(lhs, rhs)
}

public extension SVG {
    
    public var path: CGPath {
        let path = CGPath.mutable
        add(to: path)
        return path
    }
}

#if os(iOS)
    import UIKit
    
    public struct PlaygroundPathStyle {
        public static var fillColor: CGColor = .dodgerBlue
        public static var strokeColor: CGColor = .dodgerBlue
        public static var fillAlpha: CGFloat = 0.15
        public static var strokeAlpha: CGFloat = 1
        public static var lineWidth: CGFloat = 0.5
    }
    
    public extension SVG {

        public var customPlaygroundQuickLook: PlaygroundQuickLook {
//            var t = CGAffineTransform(scaleX: 1, y: -1)
//            guard let flippedPath = path.copy(using: &t) else {
//                return .text(String(describing: self))
//            }
//            let ui = UIBezierPath(cgPath: flippedPath)
//            ui.usesEvenOddFillRule = true
//            return .bezierPath(ui)
            // Workaround for plyagrounds bug: http://stackoverflow.com/questions/43432510/cant-visualize-uibezierpath-in-playground
            let box = path.boundingBoxOfPath
            let view = UIView(frame: (box.size + 4).rect())
            let shape = CAShapeLayer(path: path)
            shape.fillRule = kCAFillRuleEvenOdd
            shape.fillColor = PlaygroundPathStyle.fillColor.with(alpha: PlaygroundPathStyle.fillAlpha)
            shape.strokeColor = PlaygroundPathStyle.strokeColor.with(alpha: PlaygroundPathStyle.strokeAlpha).with(alpha: PlaygroundPathStyle.strokeAlpha)
            shape.lineWidth = PlaygroundPathStyle.lineWidth
            shape.bounds = box
            shape.position = view.layer.bounds.center
            view.layer.addSublayer(shape)
            return .view(view)
        }
    }
#elseif os(OSX)
    import AppKit
    
    public extension SVG {
        
        public var customPlaygroundQuickLook: PlaygroundQuickLook {
            let ns = NSBezierPath(cgPath: path)
            ns.windingRule = .evenOddWindingRule
            return .bezierPath(ns)
        }
    }
#else
    public extension SVG {
        
        public var customPlaygroundQuickLook: PlaygroundQuickLook {
            return .text("TODO: Quick Look for SVG types!")
        }
    }
#endif
