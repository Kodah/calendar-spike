//: [Previous](@previous)
import EnamelKit

UIFont.registerSkyFonts()

let font = UIFont(name: "SkyText-Regular", size: 44)!.poke{ $0.fontName }
let smallFont = font.withSize(36)

let color: UIColor = .orange
let lightColor: UIColor = .lightGray

let whiteBackground: NSStringAttribute = .background(.white)
let shadow = NSShadow(radius: 5, alpha: 0.2, dy: 5)

do {
    let leftStyle: [NSStringAttribute] = [
        .font(font),
        .color(.white),
        .background(CGColor.skyBlue.ui),
        .shadow(shadow)
    ]
    let rightStyle = leftStyle.with(
        .font(smallFont),
        .background(.black)
    )
    let left = "6.8".with(leftStyle)
    let right = "GB".with(rightStyle)
    left + right // 🖥 show result
}
do {
    let left = "6.8".with(font, color, shadow)
    let right = "GB".with(smallFont, lightColor, whiteBackground)
    left + right // 🖥 show result
    (left + right).scaled(by: 2) // 🖥 show result
}


//: [Next](@next)
