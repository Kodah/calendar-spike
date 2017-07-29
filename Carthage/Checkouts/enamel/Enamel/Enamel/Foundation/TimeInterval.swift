//
//  TimeInterval.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 01/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension TimeInterval {
    
    public var seconds: TimeInterval { return TimeInterval(self) }
    public var milliseconds: TimeInterval { return TimeInterval(self) / 1_000 }
    public var microseconds: TimeInterval { return TimeInterval(self) / 1_000_000 }
    public var nanoseconds: TimeInterval { return TimeInterval(self) / 1_000_000_000 }
    
    public var second: TimeInterval { return seconds }
    public var millisecond: TimeInterval { return milliseconds } 
    public var microsecond: TimeInterval { return microseconds }
    public var nanosecond: TimeInterval { return nanoseconds }
}
