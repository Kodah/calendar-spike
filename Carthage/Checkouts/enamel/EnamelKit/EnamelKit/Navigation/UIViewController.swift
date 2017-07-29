//
//  UIViewController.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 15/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension UIViewController {
    
    public func performSegue<ID: RawRepresentable>(withIdentifier id: ID, sender: AnyObject?)
        where ID.RawValue == String
    {
        performSegue(withIdentifier: id.string, sender: sender)
    }
}

// MARK:- Hierarchy traversal

public extension UIApplication {
    
    public var rootViewController: UIViewController? {
        return delegate?.window??.rootViewController
    }
    
    public var topViewController: UIViewController? {
        return rootViewController?.topViewController
    }
}

public extension UIViewController {
    
    public var ancestors: Ancestors {
        return Ancestors(of: self)
    }
    
    public var descendants: Descendants {
        return Descendants(of: self)
    }
    
    public var topViewController: UIViewController {
        let o = topPresentedViewController
        return o.childViewControllers.last?.topViewController ?? o
    }
    
    public var topPresentedViewController: UIViewController {
        return presentedViewController?.topPresentedViewController ?? self
    }
}

extension UIViewController {
    
    public struct Ancestors: IteratorProtocol, Sequence {
        
        private weak var vc: UIViewController?
        
        public mutating func next() -> UIViewController? {
            guard let vc = vc?.parent ?? vc?.presentingViewController else {
                return nil
            }
            self.vc = vc
            return vc
        }
        
        public init(of vc: UIViewController) {
            self.vc = vc
        }
    }

    public struct Descendants: IteratorProtocol, Sequence {
        
        private weak var root: UIViewController?
        private var index = -1
        private var nextDescendant: (() -> UIViewController?)?
        
        public mutating func next() -> UIViewController? {
            if let vc = nextDescendant?() {
                return vc
            }
            guard let root = root else {
                return nil
            }
            while index < root.childViewControllers.endIndex - 1 {
                index += 1
                let vc = root.childViewControllers[index]
                var descendants = vc.descendants
                nextDescendant = { return descendants.next() }
                return vc
            }
            guard let vc = root.presentedViewController, root === vc.presentingViewController else {
                return nil
            }
            self.root = nil
            var descendants = vc.descendants
            nextDescendant = { return descendants.next() }
            return vc
        }
        
        public init(of vc: UIViewController) {
            root = vc
        }
    }
}

