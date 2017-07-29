//
//  Font.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 24/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#if os(iOS)
    import UIKit
    
    public typealias Font = UIFont
    
#elseif os(OSX)
    import AppKit
    
    public typealias Font = NSFont
    
    public extension NSFont {
        
        public func withSize(_ fontSize: CGFloat) -> NSFont {
            return NSFontManager.shared().convert(self, toSize: pointSize)
        }
    }
#endif
