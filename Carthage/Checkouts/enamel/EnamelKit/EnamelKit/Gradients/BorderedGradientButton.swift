//
//  BorderedGradientButton.swift
//  EnamelKit
//
//  Created by Wilkinson, Jack (Technology) on 05/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
open class BorderedGradientButton: UIPaddedGradientButton {
    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open func commonInit() {
        borderWidth = 1.5
        cornerRadius = 4
        colors = [.yellow, .red]
    }
}
