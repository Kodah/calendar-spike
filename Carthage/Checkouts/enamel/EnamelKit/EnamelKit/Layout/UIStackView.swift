//
//  UIStackView.swift
//  EnamelKit
//
//  Created by Jung, Matthew (Associate Software Developer) on 10/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import UIKit

extension UIStackView {
    public func addArrangedSubviews(views: [UIView?]) {
        let $ = views.flatMap { $0 }
        $.forEach { addArrangedSubview($0) }
    }
}
