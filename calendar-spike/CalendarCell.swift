//
//  CalendarCell.swift
//  calendar-spike
//
//  Created by Sugarev, Thomas (iOS Developer) on 29/07/2017.
//  Copyright © 2017 Sugarev, Thomas (iOS Developer). All rights reserved.
//

import EnamelKit
import JTAppleCalendar

enum DayState {
    case unavailable
    case available
    case today
    case selected
    
    var theme: Theme {
        switch self {
        case .unavailable:
            return Theme(textColor: UIColor.gray.withAlphaComponent(0.4), circleColor: .clear)
        case .available:
            return Theme(textColor: UIColor.blue, circleColor: .clear)
        case .today:
            return Theme(textColor: UIColor.black, circleColor: UIColor.gray.withAlphaComponent(0.4))
        case .selected:
            return Theme(textColor: UIColor.white, circleColor: .blue)
        }
    }
}

struct Theme {
    var textColor: UIColor
    var circleColor: UIColor
}


class CalendarCell: JTAppleCell {

    var dayState: DayState = .unavailable {
        didSet {
            label.textColor = dayState.theme.textColor
            circle.fillColor = dayState.theme.circleColor.cgColor
            
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    var circle = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circle = CAShapeLayer()
        self.layer.addSublayer(circle)
    }
    
    
    override func layoutSubviews() {
        let minSize = min(bounds.height, bounds.width)
        let c = CGCircle(center: bounds.center, radius: minSize / 2)
        circle.frame = CGRect(square: minSize)
        circle.path = c.path

    }
}
