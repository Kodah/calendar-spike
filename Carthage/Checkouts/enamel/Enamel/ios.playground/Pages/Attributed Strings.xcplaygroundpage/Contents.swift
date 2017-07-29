//: [Previous](@previous)
import Enamel
import UIKit

//: - note: Check out the playground in `EnamelKit.workspace` for a more powerful text styling API.

let shadow: NSShadow = {
    let o = NSShadow()
    o.shadowBlurRadius = 5
    o.shadowColor = UIColor.black.withAlphaComponent(0.5)
    o.shadowOffset = CGSize(width: 2, height: 2)
    return o
}()

let attributes = [
    NSBackgroundColorAttributeName: UIColor(cgColor: .skyBlue),
    NSShadowAttributeName: shadow
]

let big = attributes + [
    NSFontAttributeName: UIFont.systemFont(ofSize: 24),
    NSForegroundColorAttributeName: UIColor.white
]

let small = attributes + [
    NSFontAttributeName: UIFont.systemFont(ofSize: 16),
    NSForegroundColorAttributeName: UIColor.orange
]

let left = "6.8".with(attributes: big) // 🖥 show result
let right = "GB".with(attributes: small) // 🖥 show result

left + right // 🖥 show result
(left + right).scaled(by: 3) // 🖥 show result

"£8.50".with(attributes: big).scaled(by: 2).withSuperscriptCents() // 🖥 show result

//: [Next](@next)
