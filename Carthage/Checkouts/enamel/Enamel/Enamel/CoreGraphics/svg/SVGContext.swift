import CoreGraphics

public protocol SVGContext {
    @discardableResult func close() -> Self
    @discardableResult func move(to point: CGPoint) -> Self
    @discardableResult func line(to point: CGPoint) -> Self
    @discardableResult func arc(at center: CGPoint, radius: CGFloat, startAngle: CGAngle, endAngle: CGAngle) -> Self
    @discardableResult func ellipse(at center: CGPoint, xRadius: CGFloat, yRadius: CGFloat) -> Self
    // with default implementation:
    @discardableResult func circle(at center: CGPoint, radius: CGFloat) -> Self
    @discardableResult func rectangle(_ rect: CGRect) -> Self
    // TODO: add curves!
}

public extension SVGContext {
    
    
    public func circle(at center: CGPoint, radius: CGFloat) -> Self {
        return ellipse(at: center, xRadius: radius, yRadius: radius)
    }
    
    public func rectangle(rect: CGRect) -> Self {
        return move(to: CGPoint(x: rect.minX, y: rect.minY))
            .line(to: CGPoint(x: rect.minX, y: rect.maxY))
            .line(to: CGPoint(x: rect.maxX, y: rect.maxY))
            .line(to: CGPoint(x: rect.maxX, y: rect.minY))
            .line(to: CGPoint(x: rect.minX, y: rect.minY))
            .close()
    }
}
