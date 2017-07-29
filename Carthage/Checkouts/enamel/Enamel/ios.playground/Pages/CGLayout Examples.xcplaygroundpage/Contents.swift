//: [Previous](@previous)
//: # CGLayout Examples
//: - note: Check out the playground in `EnamelKit.workspace` for more elaborate layout examples.
import Enamel
import UIKit

do {
    let view = UIView(frame: CGRect(square: 100))
    view.layer.backgroundColor = .dimGray
    
    let label = UILabel(frame: .unit)
    label.textColor = .white
    label.text = "where?"
    
    label.fitting(.bottom(.center))
        .padded(by: 5)
        .arrange(in: view.bounds)
    
    view.addSubview(label) // 🖥 show result
}
do {
    let layout = 13.of{ CGLayoutLeaf().aspectFitting(square: 5) }
        .tiled(rows: 3, cols: 5)
    layout.arrange(in: CGRect(width: 150, height: 40))
    layout.leaves(ofType: CGLayoutLeaf.self).svg // 🖥 show result
}
//: [Next](@next)
