//
//  StreacherViewController.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 11/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

open class StreacherViewController: UIViewController {
    
    var containerView: UIView? { return view.subviews.first }
    
    public private(set) lazy var pinchRecognizer: UIPinchGestureRecognizer = UIPinchGestureRecognizer(
        target: self,
        action: #selector(pinch)
    )
    
    public private(set) var containerSizeAtPinchBegan: CGSize?
    
    open override func viewDidLoad() {
        view.addGestureRecognizer(pinchRecognizer)
    }
    
    public func pinch(with recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state
        {
        case .began:
            containerSizeAtPinchBegan = containerView?.frame.size
            
        case .changed:
            guard
                let size = containerSizeAtPinchBegan,
                let orientation = recognizer.orientation
                else
            {
                return
            }
            containerView?.frame = size
                .scaled(by: recognizer.scale, orientation: orientation)
                .rect(center: view.bounds.center)
                .integral
                .poke("Container View Size"){ "\($0.size.width) ✕ \($0.size.height)" }
            
        default:
            containerSizeAtPinchBegan = nil
        }
    }
    
    override open func viewDidLayoutSubviews() {
        containerView?.frame.center = view.bounds.center
    }
}

extension CGSize {
    
    func scaled(by factor: CGFloat, orientation: UIPinchGestureRecognizer.Orientation) -> CGSize {
        switch orientation {
        case .diagonal: return self * factor
        case .horizontal: return self * (factor, 1)
        case .vertical: return self * (1, factor)
        }
    }
}
