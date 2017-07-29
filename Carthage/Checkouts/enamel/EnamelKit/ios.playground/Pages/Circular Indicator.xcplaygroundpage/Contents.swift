import PlaygroundSupport
let view = UIView(frame: CGRect(square: 300))
view.layer.backgroundColor = .skyBlue
PlaygroundPage.current.liveView = view
//: - note: Open timeline view in the assistant editor.
import EnamelKit

let make: () -> LabeledCircularIndicator = {
    let o = LabeledCircularIndicator(frame: view.bounds.scaledBy(factor: 0.6))
    o.title = "So round".with(UIFont.Sky.medium.font)
    o.subtitle = "and colourful".with(UIFont.Sky.regular.font)
    o.colors = [.blue, .red]
    o.angle = 45.degrees
    o.fraction = 0.75
    return o
}

async(after: 1.second) {
    let indicator = make()
    view.addSubview(indicator)
    
    async(after: 2.seconds) {
        indicator.hideTitles()
        
        async(after: 2.seconds) {
            indicator.showTitles()
        }
    }
}