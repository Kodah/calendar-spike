//
//  UIPinchGestureRecognizer.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension UIPinchGestureRecognizer {
    
    public var angle: CGAngle? {
        guard numberOfTouches == 2 else {
            return nil
        }
        let p1 = location(ofTouch: 0, in: view)
        let p2 = location(ofTouch: 1, in: view)
        return p1.angle(to: p2)
    }
}

public extension UIPinchGestureRecognizer {
    
    public enum Orientation: String, CustomStringConvertible {
        
        case horizontal
        case vertical
        case diagonal
        
        public var description: String { return string }
    }
    
    public var orientation: Orientation? {
        guard let angle = angle?.inDegrees else {
            return nil
        }
        
        let isDiagonal = angle
            .truncatingRemainder(dividingBy: 90)
            .abs
            .distance(to: 45)
            .abs < 45 / 2
        
        if isDiagonal {
            return .diagonal
        }
        
        let isVertical = angle
            .truncatingRemainder(dividingBy: 180)
            .abs
            .distance(to: 90)
            .abs < 45 / 2
        
        if isVertical {
            return .vertical
        }
        else {
            return .horizontal
        }
    }
}
