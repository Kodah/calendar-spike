//: Thinking aloud about circular indicator label layout...
import EnamelKit

let indicator = CircularIndicator(frame: CGRect(square: 120))
indicator.fraction = 0.9

let title = UIGradientLabel(frame: .unit)
title.attributedText = "Title & Title".with(UIFont.Sky.medium.font.withSize(36))
title.gradient.uiColors = indicator.colors
//title.backgroundColor = UIColor(white: 0, alpha: 0.1)
let subtitle = UILabel(frame: .unit)
subtitle.attributedText = "Subtitle".with(UIFont.Sky.medium.font.withSize(24))
subtitle.textColor = .gray
//subtitle.backgroundColor = UIColor(white: 0, alpha: 0.1)
let titleSize = title.attributedText!.size()
let subtitleSize = subtitle.attributedText!.size()

let titleFrame = titleSize.rect()
let subtitleFrame = subtitleSize.rect(
    aligned: .bottom(.center),
    outside: titleFrame,
    spacing: -4 // note the negative spacing!
)
let union = titleFrame.union(subtitleFrame)
let g = [titleFrame, subtitleFrame].group(withFrame: union) // 🖥 show result
let bounds = indicator.arc.circle.inscribedRect(withAspectRatioOf: union.size) - 5
var scaled = g.scaledBy(factor: bounds.width / union.width) // 🖥 show result
scaled.origin = bounds.origin

title.fitting(.center).arrange(in: scaled[0])
subtitle.fitting(.center).arrange(in: scaled[1])

indicator.addSubviews(title, subtitle) // 🖥 show result
