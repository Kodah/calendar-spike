//
//  Alert.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 08/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct AlertOK {
    
    public let title: String
    public let message: String
    private let ok: () -> ()
    
    public init(title: String, message: String, ok: @escaping () -> () = { note("OK") }) {
        self.title = title
        self.message = message
        self.ok = ok
    }
    
    public func show(in viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultButton = UIAlertAction(title: "OK", style: .default) { _ in self.ok() }
        alert.addAction(defaultButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
