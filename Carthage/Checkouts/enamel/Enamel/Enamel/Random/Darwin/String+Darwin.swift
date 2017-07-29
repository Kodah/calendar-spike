//
//  String+Darwin.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 28/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Darwin

public extension String {
    
    public var sample: String? { return characters.sample.map(String.init(_:)) }
    public var shuffled: String { return String(characters.shuffled) }
}
