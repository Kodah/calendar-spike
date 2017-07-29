//
//  Sky.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 13/05/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public enum Sky {}

// MARK:- Colors

// todo...

// MARK:- Fonts

extension Sky {
    
    public enum font {
        public static let regular = UIFont.Sky.regular.font
        public static let italic = UIFont.Sky.italic.font
        public static let light = UIFont.Sky.light.font
        public static let medium = UIFont.Sky.medium.font
        public static let bold = UIFont.Sky.bold.font
    }
}

public extension UIFont {
    
    public enum Sky: String {
        case regular = "SkyText-Regular"
        case italic = "SkyText-Italic"
        case light = "SkyText-Light"
        case medium = "SkyText-Medium"
        case bold = "SkyText-Bold"
        
        public var font: UIFont {
            if !Sky.fontsAreRegistered { UIFont.registerSkyFonts() }
            return UIFont(name: string, size: UIFont.systemFontSize)!
        }
        
        public fileprivate(set) static var fontsAreRegistered = false
    }
    
    public static func registerSkyFonts() {
        registerCustomFonts(bundle: EnamelKitBundle)
        Sky.fontsAreRegistered = true
    }
}
