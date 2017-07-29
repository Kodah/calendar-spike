//
//  CollectionType+Darwin.swift
//  Enamel
//
//  Created by Milos Rankovic on 11/04/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Darwin

public extension Collection {
    
    public var sample: Iterator.Element? {
        guard isNotEmpty else { return nil }
        let max = count.advanced(by: -1)
        let off = (0...max).random
        let idx = index(startIndex, offsetBy: off)
        return self[idx]
    }
}

public extension Collection where Index == Indices.Iterator.Element {
    
    public var shuffled: [Iterator.Element] {
        var indices = self.indices.array
        var o: [Iterator.Element] = []
        o.reserveCapacity(indices.count)
        while let j = (0..<indices.count).sample {
            let index = indices.remove(at: j)
            o.append(self[index])
        }
        return o
    }
}
