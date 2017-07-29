//
//  Bool+Darwin.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 20/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Darwin

public extension Bool {
    
    public static var random: Bool { return arc4random() & 1 == 1 }
}
