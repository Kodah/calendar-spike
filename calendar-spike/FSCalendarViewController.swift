//
//  CalendarView.swift
//  calendar-spike
//
//  Created by Sugarev, Thomas (iOS Developer) on 28/07/2017.
//  Copyright © 2017 Sugarev, Thomas (iOS Developer). All rights reserved.
//

import EnamelKit
import FSCalendar

class BoldCell: FSCalendarCell {

    
    override func configureAppearance() {
        super.configureAppearance()
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
    }
}

@IBDesignable
class FSCalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet var navigationButtons: [UIButton]!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBAction func nextMonthButtonTapped(_ sender: UIButton) {
        let d = calendar.currentPage.shiftMonth(by: 1)
        calendar.setCurrentPage(d!, animated: true)
    }
    @IBAction func previousMonthButtonTapped(_ sender: Any) {
        let d = calendar.currentPage.shiftMonth(by: -1)
        calendar.setCurrentPage(d!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationButtons.forEach{
            calendar.bringSubview(toFront: $0)
        }
    }
    
    lazy var availableDates: [Date] = {
       
        let today = Date()
        let intervals = 5.of { (2...10).random }
        
        return intervals.flatMap {
            return Date(timeInterval: TimeInterval(86400 * $0), since: today)
        }
    }()
    
    func availableDates(_ dates: [Date], containsDate date: Date, calendar: Calendar) -> Bool {
        
        for d in dates {
            if calendar.isDate(d, inSameDayAs: date) {
                return true
            }
        }
        return false
    }
    
    var selectedDate: Date?
    
    
     // MARK:- FSCalendarDataSource
    func maximumDate(for calendar: FSCalendar) -> Date {
        
        return Date().shiftMonth(by: 1)!
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date().shiftMonth(by: -1)!
    }

    override func loadView() {
        super.loadView()
        calendar.register(BoldCell.self, forCellReuseIdentifier: "BoldCell")
    }
    
    // MARK:- FSCalendarDelegate

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let available = availableDates(availableDates, containsDate: date, calendar: Calendar.current)
        
        guard available else {
            print("unavailable")
            calendar.deselect(date)
            return
        }
        
        selectedDate = date
        
        print("Booking changed to \(date)")
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        
        let available = availableDates(availableDates, containsDate: date, calendar: Calendar.current)

        let identifier = available ? "BoldCell" : FSCalendarDefaultCellReuseIdentifier
        
        return calendar.dequeueReusableCell(withIdentifier: identifier, for: date, at: position)
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {

        var color: UIColor? = nil //appearance.titleDefaultColor
        availableDates.forEach {
            if Calendar.current.isDate(date, inSameDayAs: $0) {
                color = CGColor.royalBlue.ui
                
            }
        }
        
        return color
    }
    
}
