//
//  Edges.swift
//  Enamel
//
//  Created by Prescott, Ste on 30/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct Edges : OptionSet {
    
    public let rawValue: Int
    
    public static let none    = Edges(rawValue: 0)
    public static let top     = Edges(rawValue: 1 << 0)
    public static let right   = Edges(rawValue: 1 << 1)
    public static let bottom  = Edges(rawValue: 1 << 2)
    public static let left    = Edges(rawValue: 1 << 3)
    public static let all     = Edges(rawValue: 1 << 4)
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
