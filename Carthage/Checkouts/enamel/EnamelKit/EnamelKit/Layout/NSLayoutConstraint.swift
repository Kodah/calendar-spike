//
//  NSLayoutConstraint.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 17/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Enamel
import UIKit

public func NSLayoutConstraints(_ format: String, options: NSLayoutFormatOptions = [], views: UIView...) -> [NSLayoutConstraint] {
    return NSLayoutConstraints(format, options: options, views: views)
}

public func NSLayoutConstraints(_ format: String, options: NSLayoutFormatOptions = [], views: [UIView] = []) -> [NSLayoutConstraint] {
    if format.hasPrefix("B:") {
        let format = format.substring(from: format.index(after: format.startIndex))
        let h = NSLayoutConstraints("H\(format)", options: options, views: views)
        let v = NSLayoutConstraints("V\(format)", options: options, views: views)
        return h + v
    }
    var dict: [String:UIView] = [:]
    for (i, v) in views.enumerated() {
        dict["v\(i + 1)"] = v
    }
    let format = format.replacingOccurrences(of: "[v]", with: "[v1]")
    return NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: nil, views: dict)
}

public extension UIView { // layout constraints
    
    /// useMask of nil will not affect the views' translatesAutoresizingMaskIntoConstraints
    public func addConstraints(withVisualFormat format: String, options: NSLayoutFormatOptions = [], useMask: Bool? = false, views: UIView...) {
        if let useMask = useMask {
            for view in views {
                view.translatesAutoresizingMaskIntoConstraints = useMask
            }
        }
        addConstraints(NSLayoutConstraints(format, options: options, views: views))
    }
    
    public func addSubview(_ view: UIView, constraints: String, options: NSLayoutFormatOptions = [], useMask: Bool? = false) {
        addSubview(view)
        addConstraints(withVisualFormat: constraints, options: options, useMask: useMask, views: view)
    }

    public func insertSubview(_ view: UIView, above sibling: UIView, constraints: String, options: NSLayoutFormatOptions = [], useMask: Bool? = false) {
        insertSubview(view, aboveSubview: sibling)
        addConstraints(withVisualFormat: constraints, options: options, useMask: useMask, views: view)
    }

    public func insertSubview(_ view: UIView, below sibling: UIView, constraints: String, options: NSLayoutFormatOptions = [], useMask: Bool? = false) {
        insertSubview(view, belowSubview: sibling)
        addConstraints(withVisualFormat: constraints, options: options, useMask: useMask, views: view)
    }
}
