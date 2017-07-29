//
//  UIButton.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 21/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension UIButton {
    
    open func allowWordWrapping() {
        titleLabel?.allowWordWrapping()
    }
    
    /// Shortcut for a rather obscure set of options that 
    /// address a common requirement.
    open func keepImageAspectFit() { // FIXME: needs a better name
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        imageView?.contentMode = .scaleAspectFit
    }
}

