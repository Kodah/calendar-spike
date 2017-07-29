//
//  CAGradientLayer.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 21/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension CAGradientLayer {
    
    public var uiColors: [UIColor] {
        get {
            return colors?
                .filter(CGColor.self)
                .map(UIColor.init(cgColor:)) ?? []
        }
        set {
            colors = newValue.map{ $0.cgColor }
        }
    }
}
