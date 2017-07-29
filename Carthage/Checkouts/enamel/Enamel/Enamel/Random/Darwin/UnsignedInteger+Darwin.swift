//
//  UnsignedIntegerType.swift
//  Enamel
//
//  Created by Milos Rankovic on 11/04/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Darwin

public extension UnsignedInteger {
    
	public static var random: Self {
		let foot = MemoryLayout<Self>.size
		if foot < ARC4Foot {
			return numericCast(arc4random() & numericCast(max))
		}
		var r = UIntMax(arc4random())
		for i in 1..<(foot / ARC4Foot) {
			r |= UIntMax(arc4random()) << UIntMax(8 * ARC4Foot * i)
		}
		return numericCast(r)
	}
}

private func sizeof <T> (_: () -> T) -> Int {
    return MemoryLayout<T>.size
}

private let ARC4Foot: Int = sizeof(arc4random)
