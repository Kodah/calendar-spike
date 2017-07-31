//
//  CalendarJTViewController.swift
//  calendar-spike
//
//  Created by Sugarev, Thomas (iOS Developer) on 29/07/2017.
//  Copyright © 2017 Sugarev, Thomas (iOS Developer). All rights reserved.
//

import JTAppleCalendar
import EnamelKit

class JTCalendarViewController: UIViewController {
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    lazy var availableDates: [Date] = {
        
        let today = Date()
        let intervals = 5.of { (2...10).random }
        
        return intervals.flatMap {
            return Date(timeInterval: TimeInterval(86400 * $0), since: today)
        }
    }()
    
    func dateIsAvailable(date: Date) -> Bool {
        for availableDate in availableDates {
            if Calendar.current.isDate(date, equalTo: availableDate, toGranularity: .day) {
                return true
            }
        }
        return false
    }
}

extension JTCalendarViewController: JTAppleCalendarViewDelegate {
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "Celll", for: indexPath) as! CalendarCell
        
        cell.label.text = cellState.text
        
        cell.dayState = .unavailable
        if Calendar.current.isDateInToday(date) {
            cell.dayState = .today
        }
        
        if dateIsAvailable(date: date) {
            cell.dayState = .available
        }

        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? CalendarCell else { return }
        
        
        cell.dayState = .selected

    }
}

extension JTCalendarViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        var components = Calendar.current.dateComponents([.calendar, .year, .month], from: Date())
        components.setValue(1, for: .day)
        
        let startDate = Calendar.current.date(from: components)!
        let endDate = startDate.shiftMonth(by: 1)!
        
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}
