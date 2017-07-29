//
//  UINavigationController.swift
//  EnamelKit
//
//  Created by Prescott, Ste on 21/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

extension UINavigationController {
    public func popToFirstInstance<T>(of type: T.Type, animated: Bool = true) {
        guard
            let first = viewControllers.first(type),
            let vc = first as? UIViewController
        else { return }
        
        popToViewController(vc, animated: animated)
    }
}
