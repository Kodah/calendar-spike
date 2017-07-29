//: [Previous](@previous)
import UIKit
import Enamel
import PlaygroundSupport


let view = UIView(frame: CGRect(square: 300))
view.backgroundColor = UIColor.lightGray

PlaygroundPage.current.liveView = view

let labels = 25.of{ UILabel(frame: .zero) }

labels.enumerated().forEach {
    
    $1.text = "\($0)"
    $1.backgroundColor = UIColor(hue: (1...100).random.cg / 100,
                                 saturation: 0.65,
                                 brightness: 1,
                                 alpha: 1)
    $1.font = UIFont.boldSystemFont(ofSize: (20...50).random.cg)
    $1.sizeToFit()
}

labels.forEach {
    view.addSubview($0)
    $0.frame
}

let topLeft = CGFlowLayout(
    child: .set(spacing: 3, alignment: .right(.bottom)),
    line: .set(spacing: 3, alignment: .bottom(.left)),
    children: labels)
let topCenter = CGFlowLayout(
    child: .set(spacing: 3, alignment: .right(.center)),
    line: .set(spacing: 3, alignment: .bottom(.center)),
    children: labels)
let topRight = CGFlowLayout(
    child: .set(spacing: 3, alignment: .right(.top)),
    line: .set(spacing: 3, alignment: .bottom(.right)),
    children: labels)
let topLeftVertical = CGFlowLayout(
    child: .set(spacing: 3, alignment: .bottom(.left)),
    line: .set(spacing: 3, alignment: .right(.top)),
    children: labels)
let topCenterVertical = CGFlowLayout(
    child: .set(spacing: 3, alignment: .bottom(.center)),
    line: .set(spacing: 3, alignment: .right(.center)),
    children: labels)
let topRightVertical = CGFlowLayout(
    child: .set(spacing: 3, alignment: .bottom(.right)),
    line: .set(spacing: 3, alignment: .right(.bottom)),
    children: labels)
let reverse = CGFlowLayout(
    child: .set(spacing: 3, alignment: .left(.bottom)),
    line: .set(spacing: 3, alignment: .bottom(.right)),
    children: labels)


let layouts = [topLeft, topCenter, topRight, topLeftVertical, topCenterVertical, topRightVertical, reverse]

var index = 0
async(every: 2.second) { i in
    let l = layouts[index]
    
    if index == layouts.count - 1 {
        index = 0
    } else {
        index += 1
    }
    
    UIView.animate(withDuration: 1, animations: {
        l.arrange(in: view.bounds)
    })
    return true
}




//: [Next](@next)
