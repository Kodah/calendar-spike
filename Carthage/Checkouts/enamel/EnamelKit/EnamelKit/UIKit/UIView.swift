//
//  UIView.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 16/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension UIView {
    
    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
    
    public func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
}

// MARK:- experimental

public protocol CanSizeToFit {
    func sizeToFit()
}

extension CanSizeToFit {
    
    public var sizedToFit: Self {
        sizeToFit()
        return self
    }
}

extension UIView: CanSizeToFit {}

