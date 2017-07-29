import UIKit
import Enamel

class View: UIView {
    var shape: CGPath? {
        get { return (layer as? CAShapeLayer)?.path }
        set { (layer as? CAShapeLayer)?.path = newValue }
    }
    override class var layerClass: AnyClass { return CAShapeLayer.self }
    convenience init() {
        self.init(frame: CGRect(square: 40))
        layer.backgroundColor = .skyBlue
        layer.isGeometryFlipped = true
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
