//
//  CalendarJTViewController.swift
//  calendar-spike
//
//  Created by Sugarev, Thomas (iOS Developer) on 29/07/2017.
//  Copyright © 2017 Sugarev, Thomas (iOS Developer). All rights reserved.
//

import JTAppleCalendar
import UIKit
import EnamelKit

class bacon: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "Celll", for: indexPath) as! CalendarCell
        
        cell.label.text = cellState.text
        
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        var components = Calendar.current.dateComponents([.month, .year], from: Date())
        components.setValue(1, for: .day)
        
        let startDate = Calendar.current.date(from: components)!
        
        let endDate = startDate.shiftMonth(by: 1)!
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}
