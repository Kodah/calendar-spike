//
//  Bool.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 25/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- not

public extension Bool {
    
    public var not: Bool { return !self }
    
    public mutating func toggle() {
        self = !self
    }
}
