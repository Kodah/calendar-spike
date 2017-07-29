//: [Previous](@previous)
//: # Aligning Rects
import Enamel

import UIKit
let view = UIView(frame: CGRect(square: 200))
view.layer.backgroundColor = .skyBlue

let labels: [UILabel] = "Dare you try layout these words?".components(separatedBy: " ").map{ text in
    let o = UILabel(frame: .unit)
    o.layer.backgroundColor = .white
    o.layer.cornerRadius = 3
    o.text = text
    o.sizeToFit()
    view.addSubview(o)
    return o
}

let sizes = labels.map{ $0.frame.size }
//: ### CGRectGroup
var group = CGRectGroup( // 🖥 show result
    aligning: .bottom(.center),
    sizes: sizes,
    anchor: .center,
    position: view.bounds.center,
    padding: 5,
    spacing: 3
)

zip(labels, group).forEach{ $0.frame = $1 }
view // 🖥 show result

let r1 = CGRect(x: -50, y: 71, width: 100, height: 50)
let r2 = CGSize(square: 20).rect(aligned: .bottom(.right), outside: r1)
let r3 = r2.size.rect(aligned: .bottom(.right), inside: r1)

[r1, r2, r3].svg // 🖥 show result

var rnd: CGFloat { return (5...20).random.cg }

15.of{ CGSize(width: rnd, height: rnd) }
    .rects(aligned: .left(.bottom), padding: 5, spacing: 3) // 🖥 show result
do {
    let bounds = CGRect(square: 100)
    let box1 = CGSize(width: 20, height: 10).rect(
        aligned: .bottom(.right),
        inside: bounds - 5
    )
    let box2 = CGSize(width: 10, height: 20).rect(
        aligned: .left(.center),
        inside: bounds - 7
    )
    let g = [box1, box2].group(withFrame: bounds) // 🖥 show result
    let sbox1 = box1.scaledBy(factor: 0.5, relativeTo: bounds.center)
    SVGGroup(g, sbox1, bounds.center.dot) // 🖥 show result
    g.scaledBy(factor: 0.66, relativeTo: g.frame.topRight) + bounds // 🖥 show result
}
//: ### CGLayoutGroup
let lr1 = CGLayoutRect( // 🖥 show result
    inner: CGSize(square: 20),
    margin: CGOff(hor: 20, ver: 5),
    padding: 3
)
let lr2 = CGLayoutRect(
    aligned: .left(.center),
    outside: lr1,
    size: lr1.size
)
lr1 + lr2 // 🖥 show result


let layoutSizes = 3.of{ lr1.size }

CGLayoutGroup(aligning: .bottom(.center), sizes: layoutSizes) // 🖥 show result
CGLayoutGroup(aligning: .right(.center), sizes: layoutSizes) // 🖥 show result

layoutSizes.rects(aligned: .right(.center)) // 🖥 show result

//: [Next](@next)
