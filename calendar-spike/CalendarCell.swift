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
}


class CalendarCell: JTAppleCell {

    var dayState: DayState = .unavailable {
        didSet{
            layoutSubviews()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    private var circle = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circle = CAShapeLayer()

        
        self.layer.addSublayer(circle)
    }
    
    override func layoutSubviews() {
        let rect = bounds
        let minSize = min(rect.height, rect.width)
        let c = CGCircle(center: rect.center, radius: minSize / 2)
        circle.frame = CGRect(square: minSize)
        circle.path = c.path
        circle.fillColor = CGColor.green.with(alpha: 0.5)
    }
}
