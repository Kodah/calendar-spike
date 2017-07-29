import AppKit
import Enamel

class View: NSView {
    var shape: CGPath? {
        get { return (layer as? CAShapeLayer)?.path }
        set { (layer as? CAShapeLayer)?.path = newValue }
    }
    convenience init() {
        self.init(frame: CGRect(square: 40))
        layer = CAShapeLayer()
        layer?.backgroundColor = .orange
        layer?.isGeometryFlipped = false
    }
}

let view = View()
let arc =  CGArc(
    center: view.bounds.center,
    radius: view.bounds.size.min / 2 - 5,
    startAngle: 0.degrees,
    angle: 180.degrees,
    clockwise: true
)
view.shape = arc.path
view
