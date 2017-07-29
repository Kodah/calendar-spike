//
//  measure.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 13/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct TimeRecord: Hashable {
    
    public let id: String
    public let function: String
    public let file: String
    public let line: Int
    public let time: CFAbsoluteTime
    
    public var hashValue: Int { return id.hashValue }

    public static func == (lhs: TimeRecord, rhs: TimeRecord) -> Bool { return lhs.id == rhs.id }
    
    fileprivate init(
        id: String,
        function: String,
        file: String,
        line: Int,
        time: CFAbsoluteTime = CFAbsoluteTimeGetCurrent())
    {
        (self.id, self.file, self.function, self.line, self.time) = (id, file, function, line, time)
    }
    
    public fileprivate(set) static var records: Set<TimeRecord> {
        get { return recordsQueue.sync{ atomicRecords } }
        set { recordsQueue.sync{ atomicRecords = newValue } }
    }
    
    fileprivate static let queue = DispatchQueue(
        label: "uk.sky.Enamel.TimeRecord.queue",
        qos: DispatchQoS.utility
    )
    
    private static var atomicRecords: Set<TimeRecord> = []
    
    private static let recordsQueue = DispatchQueue(
        label: "uk.sky.Enamel.TimeRecord.recordsQueue",
        qos: DispatchQoS.utility
    )
}

public func measure<ID>(
    start id: @escaping @autoclosure () -> ID,
    function: String = #function,
    file: String = #file,
    line: Int = #line)
{
    #if DEBUG
        TimeRecord.queue.async {
            let record = TimeRecord(
                id: "\(id())",
                function: function,
                file: file,
                line: line
            )
            TimeRecord.records.insert(record)
        }
    #endif
}

public func measure<ID, Info>(
    end id: @escaping @autoclosure () -> ID,
    info: @escaping @autoclosure () -> Info,
    precision: Int = 4,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    time: CFAbsoluteTime = CFAbsoluteTimeGetCurrent(),
    if shouldLog: ((CFAbsoluteTime) -> Bool)? = nil)
{
    #if DEBUG
        TimeRecord.queue.async {
            let id = "\(id())"
            guard let r = TimeRecord.records.first(where: { $0.id == id }) else {
                note("measure error: id \(id) has not been started!", function: function, file: file, line: line)
                return
            }
            TimeRecord.records.remove(r)
            let dt = time - r.time
            guard shouldLog?(dt) ?? true else {
                return
            }
            let msg = "\(info())"
            let sp = msg.isEmpty ? "" : " "
            let s = "measure(\(id))\(sp)\(msg): \(dt.cg.round(places: precision))"
            note(s, function: function, file: file, line: line)
        }
    #endif
}

// without `info` parameter
public func measure<ID>(
    end id: @escaping @autoclosure () -> ID,
    precision: Int = 4,
    function: String = #function,
    file: String = #file,
    line: Int = #line,
    time: CFAbsoluteTime = CFAbsoluteTimeGetCurrent(),
    if shouldLog: ((CFAbsoluteTime) -> Bool)? = nil)
{
    #if DEBUG
        TimeRecord.queue.async {
            measure(
                end: id,
                info: "",
                precision: precision,
                function: function, file: file,
                line: line,
                time: time,
                if: shouldLog
            )
        }
    #endif
}
