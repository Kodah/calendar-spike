//
//  UIStoryboard.swift
//  CircularIndicator
//
//  Created by Rankovic, Milos (Developer) on 08/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

public extension UIStoryboard {

    public func instantiateInitialViewController<ViewController: UIViewController>() -> ViewController? {
        return instantiateInitialViewController() as? ViewController
    }
    
    public func instantiateViewController<ViewController: UIViewController>(withIdentifier identifier: String) -> ViewController? {
        return instantiateViewController(withIdentifier: identifier) as? ViewController
    }
}
