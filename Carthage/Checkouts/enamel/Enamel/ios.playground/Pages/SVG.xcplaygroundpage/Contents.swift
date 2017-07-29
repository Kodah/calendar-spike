//: [Previous](@previous)
//: # SVG
import Enamel
do {
    let r = CGRect(width: 150, height: 40)
    r.incircle(aligned: .bottom(.right)) + r // 🖥 show result
    let r2 = CGRect(width: 20, height: 40)
    r2.incircle(aligned: .bottom(.right)) + r2 // 🖥 show result
}
do {
    let p = CGPoint(x: 5, y: 4)
    
    let line = CGLine(start: p, end: p.offsetBy(dx: 50))
    let angle = 30.degrees
    
    let p1 = p.offsetBy(angle: -angle, distance: line.length)

    let arc1 = CGArc(
        center: line.start,
        radius: line.length,
        angle: angle,
        direction: .counterClockwise
    )
    arc1.endAngle
    line + CGLine(start: p, end: p1) + p1.dot + arc1 // 🖥 show result
    
    let p2 = p.offsetBy(angle: angle, distance: line.length)
    let arc2 = CGArc(
        center: line.start,
        radius: line.length,
        angle: angle,
        direction: .clockwise
    )
    arc2.endAngle
    line + CGLine(start: p, end: p2) + p2.dot + arc2 // 🖥 show result
}
do {
    let circle = CGCircle(radius: 18)
    let rect = circle.frame
    let arc = CGArc(
        circle: rect.excircle,
        startFraction: -7 / 8,
        fraction: 3 / 4
    )
    arc + rect + circle // 🖥 show result
}
do {
    let chart = CGPieRing( // 🖥 show result
        circle: CGCircle(radius: 50),
        thickness: 20,
        direction: .clockwise,
        values: 25, 50, 10, 1, 15
    )
}
do {
    let circle = CGCircle(radius: 20)
    let dots = circle.points(count: 20).map{ $0.dot }
    dots.svg // 🖥 show result
}
do {
    let ellipse = CGEllipse(xRadius: 50, yRadius: 20)
    let dots = ellipse.points(count: 20).map{ $0.dot }
    dots.svg // 🖥 show result
}
do {
    let frame = CGRect(width: 223, height: 97)
    let grid = frame.grid(rows: 3, cols: 6, padding: 7, spacing: 5)
    let dots = grid.map{ $0.center.dot }
    grid + frame + dots.svg // 🖥 show result
}
do {
    let frame = CGRect(square: 10)
    let grid = frame.tiled(rows: 5, cols: 7, padding: 3, spacing: 3) // 🖥 show result
    let circles = grid.map{ $0.incircle() }
    circles.svg // 🖥 show result
}
do {
    let frame = CGRect(square: 20)
    let grid = frame.tiled(rows: 2, cols: 2, padding: 3, spacing: 3)
    let grid2 = grid[3].grid(rows: 2, cols: 2, padding: 3, spacing: 3)
    grid + grid2 // 🖥 show result
}
do {
    let bounds = CGRect(square: 100)
    var grid = CGGrid(
        aligned: .center,
        in: bounds.insetBy(margin: 5),
        rows: 3,
        cols: 6,
        cellAspectRatio: 0.8,
        spacingAsFractionOfCellWidth: 0.2
    )
    grid.array.svg + bounds // 🖥 show result
}
do {
    let rect = CGRect(square: 50)
    let tick = CGTick(rect: rect)
    tick + rect // 🖥 show result
}
do {
    let rect = CGRect(square: 10)
    let bounds = CGRect(square: 20)
    let bottomRight = CGRect(
        anchor: .bottomRight,
        position: bounds.bottomRight,
        size: rect.size
    )
    bounds + bottomRight // 🖥 show result
}
do {
    let steps = CGFloat.randomWalk(count: 100, initial: 0, range: 15)
    let points = steps.enumerated().map{ CGPoint(x: $0.cg * 8, y: $1) }
    CGPolygon(vertices: points, open: true) // 🖥 show result
}

//: [Next](@next)
