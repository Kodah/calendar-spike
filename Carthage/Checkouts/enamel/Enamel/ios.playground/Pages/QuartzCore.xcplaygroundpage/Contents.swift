//: [Previous](@previous)
//: # QuartzCore
import Enamel

let bounds = CGRect(width: 150, height: 100)
let lineWidth: CGFloat = 10
let paddedBounds = bounds.insetBy(margin: lineWidth / 2 + 1)

let layer = CAGradientLayer()
layer.cornerRadius = 5
layer.borderWidth = 0.5

layer.colors = [CGColor.azure, CGColor.skyBlue, CGColor.aliceBlue]
layer.angle = 45.degrees
layer.bounds = bounds // 🖥 show result
let mask = CAShapeLayer(path: paddedBounds.inellipse.path)
layer.mask = mask // 🖥 show result
layer
mask.fillColor = nil
mask.strokeColor = .black
mask.lineWidth = lineWidth
layer.colors = [CGColor.seaGreen, CGColor.darkOrange, CGColor.cornflowerBlue] // 🖥 show result
let arc = CGArc(circle: paddedBounds.incircle(), endAngle: 0.66.rotations)
mask.path = arc.path
layer.colors = [CGColor.black, CGColor.darkOrange, CGColor.mintCream] // 🖥 show result
let pie = CGPieRing(circle: paddedBounds.incircle(), thickness: 15, values: 25, 50, 12.5, 77)
mask.fillColor = .black; mask.strokeColor = nil
mask.path = pie.path
layer.colors = [CGColor.violet, CGColor.darkOrange, CGColor.aliceBlue] // 🖥 show result



//: [Next](@next)
