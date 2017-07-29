//
//  UIColor.swift
//  CircularIndicator
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Enamel
import UIKit

public extension CGColor {
    
    public var ui: UIColor { return UIColor(cgColor: self) }
}

public extension UIColor {
    
    public convenience init(rgb: Int) {
        self.init(rgb: rgb, alpha: 1)
    }
    
    public convenience init(rgb: Int, alpha: CGFloat) {
        let (r, g, b) = rgb.rgb
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    public convenience init(rgba: Int) {
        let (r, g, b, a) = rgba.rgba
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
