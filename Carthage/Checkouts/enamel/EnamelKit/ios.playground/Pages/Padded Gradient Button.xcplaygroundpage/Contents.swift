import EnamelKit

class Button: UIPaddedGradientButton {
    convenience init(_ title: String) {
        self.init(frame: .unit)
        setAttributedTitle(title.with(Sky.font.bold.withSize(22)), for: .normal)
        allowWordWrapping()
        gradient.colors = [CGColor.skyBlue, CGColor.salmon, CGColor.black]
        gradient.angle = 45.degrees
        borderWidth = 0.5
        cornerRadius = 4
        padding = 10
    }
}

class View: UIView {
    
    let b1 = Button("Gradient Button")
    let b2 = Button("Another Gradient Button")
    
    lazy var layout: CGLayout = self.stackLayout.snugged.padded(by: 10)

    lazy var stackLayout: CGStackLayout = CGStackLayout(
        spacing: 10,
        aligning: .bottom(.left),
        children: self.b1, self.b2
    )

    override func layoutSubviews() {
        [b1, b2].filter{ $0.superview !== self }.forEach(addSubview)
        layout.arrange(in: bounds)
    }
    
    override func size(toFit size: CGSize) -> CGSize {
        return layout.size(toFit: size)
    }
}

let view = View(frame: .unit)

view.arrange(
    in: view.size(toFit: view.unconstrainedSize / 2).rect()
)

view // 🖥 show result












