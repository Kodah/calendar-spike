//
//  UIBezierPath.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 09/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Enamel
import UIKit

public extension CGPath {
    public var ui: UIBezierPath { return UIBezierPath(cgPath: self) }
}
