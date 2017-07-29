//
//  UIViewController+Debug.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 14/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension UIViewController {
    
    public func printDescendants(every interval: TimeInterval, separator: String = "- " * 40) {
        #if DEBUG
            let type = String(describing: type(of: self))
            async(every: interval) { [weak self] _ in
                guard let this = self else {
                    print("\(type) dealocated!\n\(separator)")
                    return false
                }
                this.descendants.forEach{ print(type(of: $0)) }
                note(separator)
                return true
            }
        #endif
    }
}
