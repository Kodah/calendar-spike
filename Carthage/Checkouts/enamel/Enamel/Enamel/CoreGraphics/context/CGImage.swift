//
//  CGImage.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 13/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

extension CGImage {
    
    open static func with(width: UInt, height: UInt, color: CGColor) -> CGImage {
        return CGContext.rgb(width: width, height: height, color: color)!.image!
    }
}
