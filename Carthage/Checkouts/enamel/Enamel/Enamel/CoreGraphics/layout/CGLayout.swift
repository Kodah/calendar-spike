//
//  CGLayout.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public protocol CGLayout {
    var childLayouts: [CGLayout] { get }
    func size(toFit size: CGSize) -> CGSize
    func arrange(in rect: CGRect)
}

extension CGLayout {
    
    public var unconstrainedSize: CGSize {
        return size(toFit: CGSize(square: CGFloat(UInt16.max)))
    }
}

// MARK:- Leaves

extension CGLayout {
    
    public func leaves<Leaf>(ofType: Leaf.Type) -> [Leaf] {
        return leaves(where: { $0 as? Leaf })
    }
    
    public func leaves<Leaf>(where matching: (Any) -> Leaf?) -> [Leaf] {
        if let leaf = matching(self) {
            return [leaf]
        }
        return childLayouts.flatMap{ $0.leaves(where: matching) }
    }
    
    public func leaves(where matching: (CGLayout) -> Bool) -> [CGLayout] {
        if matching(self) {
            return [self]
        }
        return childLayouts.flatMap{ $0.leaves(where: matching) }
    }
    
    /**
     Diff based on `===` where `Leaf: AnyObject`
     */
    public func leaves<Leaf: AnyObject>(ofType: Leaf.Type, comparedTo prevLayout: CGLayout) -> (enter: [Leaf], exit: [Leaf]) {
        let selfLeaves = leaves(ofType: Leaf.self)
        let otherLeaves = prevLayout.leaves(ofType: Leaf.self)
        return selfLeaves.diff(from: otherLeaves, areEqual: ===)
    }
}
