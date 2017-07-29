//: [Previous](@previous)
//: # SVGContext
import Enamel

let circles = (1...5).map{ CGCircle(radius: $0.cg * 5) }
var svg = SVGGroup(circles)

let frame = circles.last!.frame
svg += frame // 🖥 show result

let bounds = frame + 5

let ctxt = CGContext.rgb(
    width: UInt(bounds.width),
    height: UInt(bounds.height),
    color: .salmon
)!
ctxt.translate(by: -bounds.origin)
ctxt.setStrokeColor(.white)

svg.add(to: ctxt)
ctxt.strokePath()
ctxt.image?.ui // 🖥 show result

//: [Next](@next)
