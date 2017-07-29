//: [Previous](@previous)
//: # CGLayout
//: A layout protocol
import Enamel
//: ## Layout leaves
//: These are the objects we want to layou out (imagine they are `UIView`, `NSView`, or `SKNode`s).
class Leaf: CGLayout {
    
    var frame: CGRect = .zero
    let childLayouts: [CGLayout] = []
    
    func size(toFit size: CGSize) -> CGSize {
        return size
    }
    
    func arrange(in rect: CGRect) {
        frame = rect
    }
}

extension Leaf: SVG { // this will show it in the playground
    func add(to context: SVGContext) { context.rectangle(frame) }
}
//: Here we are making subclasses of `Leaf` so that they render directly in the playground:
//:
//: `Fill: Leaf`
class Fill: Leaf {}
//: `Square: Leaf`
class Square: Leaf {
    let side: CGFloat
    init(side: CGFloat) {
        self.side = side
        super.init()
    }
    override func size(toFit size: CGSize) -> CGSize {
        return CGSize(square: side)
    }
}
//: `FillWidth: Leaf`
class FillWidth: Leaf {
    let height: CGFloat
    init(height: CGFloat) {
        self.height = height
        super.init()
    }
    override func size(toFit size: CGSize) -> CGSize {
        return size.with(height: height)
    }
}
//: `FillHeight: Leaf`
class FillHeight: Leaf {
    let width: CGFloat
    init(width: CGFloat) {
        self.width = width
        super.init()
    }
    override func size(toFit size: CGSize) -> CGSize {
        return size.with(width: width)
    }
}

//: ## Layout examples
let bounds = CGRect(width: 150, height: 40)
do {
    let layout = CGDivideLayout(
        from: .right,
        spacing: 5,
        slice: FillHeight(width: 25),
        remainder: Fill()
    ).padded(by: 5)
    layout.arrange(in: bounds)
    bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
}
do {
    let stack = 3.of{ FillHeight(width: 5) }
        .stacked(aligning: .right(.center), spacing: 5)
    do {
        let layout = CGDivideLayout(
            from: .right,
            spacing: 5,
            slice: stack,
            remainder: Fill()
        ).padded(by: 5)
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    do {
        let layout = CGDivideLayout(
            from: .right,
            slice: stack,
            remainder: Square(side: 5).aligned(.left(.bottom))
        ).padded(by: 5)
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    
    let sequence = stride(from: 5, to: 16, by: 2).map(Square.init)
    
    do {
        let layout = CGDivideLayout(
            from: .right,
            spacing: 5,
            slice: stack,
            remainder: sequence.justified(.left(.center))
        ).padded(by: 5)
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    do {
        let layout = CGDivideLayout(
            from: .right,
            spacing: 5,
            slice: stack,
            remainder: sequence.map{ $0.arranged(.center) }.tiled(rows: 2, cols: 3)
        ).padded(by: 5)
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    do {
        let squares: [Square] = 50.of{ Square(side: (5...15).random.cg) }
        let layout = CGFlowLayout(
            childSpacing: 5,
            childAlignment: .right(.bottom),
            lineSpacing: 5,
            lineAlignment: .bottom(.center),
            children: squares
            ).padded(by: 5)
        
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    do {
        let squares: [Square] = 50.of{ Square(side: (5...15).random.cg) }
        let layout = CGFlowLayout(
            child: .set(spacing: 5, alignment: .right(.bottom)),
            line: .set(spacing: 5, alignment: .bottom(.center)),
            children: squares
            ).padded(by: 5)
        
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
    do {
        let squares: [Square] = 50.of{ Square(side: (5...15).random.cg) }
        let layout = CGFlowLayout(
            line: .set(spacing: 5),
            children: squares
            ).padded(by: 5)
        
        layout.arrange(in: bounds)
        bounds + layout.leaves(ofType: Leaf.self).svg // 🖥 show result
    }
}

//: [Next](@next)
