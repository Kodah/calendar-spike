//
//  NSDate.swift
//  Enamel
//
//  Created by milos on 04/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

// FIXME: Move out of Enamel - too custom
public enum TimeOfDay: String {
    case morning
    case afternoon
    case evening
}

@available(*, unavailable, renamed: "TimeOfDay")
public typealias Period = TimeOfDay

extension Date {
    
    public var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: self)
        return hour < 12
    }
    
    public var period: TimeOfDay? {
        let hour = Calendar.current.component(.hour, from: self)
        switch hour {
        case 0  ..< 12: return .morning
        case 12 ..< 18: return .afternoon
        case 18 ..< 24: return .evening
        default: return nil
        }
    }
    
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    public var ymd: Date? {
        let calendar = Calendar.current
        let components = DateComponents(
            calendar: Calendar.current,
            year: calendar.component(.year, from: self),
            month: calendar.component(.month, from: self),
            day: calendar.component(.day, from: self)
        )
        return calendar.date(from: components)
    }
    
    public func shiftMonth(by months: Int) -> Date? {
        let components = DateComponents(month: months)
        return Calendar.current.date(byAdding: components, to: self)
    }
}

public extension Date {
    
    public var ddMMyyString: String {
        return ddMMyyFormatter.string(from: self)
    }
    
    public var ddMMMhhmmString: String {
        return ddMMMhhmmFormatter.string(from: self)
    }
    
    public var ddMMMString: String {
        return ddMMMFormatter.string(from: self)
    }
    
    public var yyyyMMddString: String {
        return yyyyMMddFormatter.string(from: self)
    }
    
    public var yyyyMMddHHmmssString: String {
        return yyyyMMddHHmmssFormatter.string(from: self)
    }
    
    public var ddMMMyyyyString: String {
        return ddMMMyyyyFormatter.string(from: self)
    }
    
    public var ddMMMMyyyyString: String {
        return ddMMMMyyyyFormatter.string(from: self)
    }
}

// FIXME: namespace + rename to indicate separators (dashes, spaces, dots and columns)

public let yyyyMMddFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "yyyy-MM-dd"
    return $
}()

public let yyyyMMddHHmmssFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return $
}()

public let ddMMyyFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "dd.MM.yy"
    return $
}()

public let ddMMMhhmmFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "dd MMM HH:mm"
    return $
}()

public let ddMMMFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "dd MMM"
    return $
}()

public let ddMMMyyyyFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "dd MMM yyyy"
    return $
}()

public let ddMMMMyyyyFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "dd MMMM yyyy"
    return $
}()

public let HHmmssFormatter: DateFormatter = {
    let $ = DateFormatter()
    $.dateFormat = "HH:mm:ss"
    return $
}()
