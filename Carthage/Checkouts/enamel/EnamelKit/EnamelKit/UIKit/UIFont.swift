//
//  UIFont.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 11/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension UIFont {
    
    public static func registerCustomFonts(
        bundle: Bundle = .main,
        inSubdirectory subdirectory: String? = nil,
        extension: String = "ttf")
    {
        let urls = bundle.urls(
            forResourcesWithExtension: "ttf",
            subdirectory: subdirectory
        )
        for url in urls ?? [] {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

extension UIFont {
    
    open func sized(_ pointSize: CGFloat) -> UIFont {
        return withSize(pointSize)
    }
}
