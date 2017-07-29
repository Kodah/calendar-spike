//
//  NSAttributedString.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 15/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let $ = lhs.mutable
    $.append(rhs)
    return $.immutable
}

public func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
    let $ = lhs.mutable
    $.append(rhs)
    lhs = $.immutable
}

public func += (lhs: inout NSMutableAttributedString, rhs: NSAttributedString) {
    lhs.append(rhs)
}

public extension NSAttributedString {
    
    public var mutable: NSMutableAttributedString {
        return mutableCopy() as! NSMutableAttributedString
    }
    
    public var immutable: NSAttributedString {
        return (self as? NSMutableAttributedString)?.copy() as? NSAttributedString ?? self
    }
    
    public var fullRange: NSRange {
        return NSMakeRange(0, length)
    }
    
    public func with(_ attributes: [String:Any]) -> NSAttributedString {
        let $ = mutable
        $.addAttributes(attributes, range: fullRange)
        return $.immutable
    }
}

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

#if os(iOS) || os(OSX)
    
    public extension NSAttributedString {
        
        public func size(_ options: NSStringDrawingOptions) -> CGSize {
            return boundingRect(with: .infinity, options: options, context: nil).size
        }
    }

    public extension NSAttributedString {
        
        public func scale(toFit size: CGSize) -> CGFloat? {
            return self.size().scale(toFit: size)
        }
        
        public func scaled(by scale: CGFloat) -> NSAttributedString {
            let $ = mutable
            $.scale(by: scale)
            return $.immutable
        }
        
        @available(*, deprecated, renamed: "sized(toFit:)")
        public func resized(toFit size: CGSize) -> NSAttributedString {
            return sized(toFit: size)
        }
        
        public func sized(toFit size: CGSize) -> NSAttributedString {
            let $ = mutable
            $.resize(toFit: size)
            return $.immutable
        }
    }
    
    public extension NSMutableAttributedString {
        
        public func scale(by scale: CGFloat) {
            enumerateAttribute(NSFontAttributeName, in: fullRange, options: []) { _, range,_ in
                let o = self.attribute(
                    NSFontAttributeName,
                    at: range.location,
                    effectiveRange: nil
                )
                guard let font = o as? Font else {
                    return
                }
                self.addAttribute(
                    NSFontAttributeName,
                    value: font.withSize((font.pointSize * scale).floor),
                    range: range
                )
            }
        }
        
        public func resize(toFit size: CGSize) {
            guard let scale = self.scale(toFit: size) else {
                return
            }
            self.scale(by: scale)
        }
    }
    
    public extension NSAttributedString {
        
        public func withSuperscript(pattern: String, fontName: String? = nil) throws -> NSAttributedString {
            let mutable = self.mutable
            try mutable.superscript(pattern: pattern, fontName: fontName)
            return mutable.immutable
        }
        
        public func withSuperscriptCents(currencySymbol symbol: String? = nil, fontName: String? = nil) -> NSAttributedString {
            let mutable = self.mutable
            mutable.superscriptCents(currencySymbol: symbol, fontName: fontName)
            return mutable.immutable
        }
    }
    
    public extension NSMutableAttributedString {
        
        public func superscript(pattern: String, fontName: String? = nil) throws {
            let r = try NSRegularExpression(pattern: pattern, options: [])
            r.enumerateMatches(in: string, options: [], range: fullRange) { match, _, _ in
                guard
                    let range = match?.rangeAt(1),
                    let baseFont = attribute(NSFontAttributeName, at: range.location - 1, effectiveRange: nil) as? Font
                    else
                {
                    return
                }
                let size = baseFont.pointSize / 2
                let font = fontName.flatMap{ Font(name: $0, size: size) } ?? baseFont.withSize(size)
                let attributes: [String:Any] = [
                    NSFontAttributeName: font,
                    NSBaselineOffsetAttributeName: baseFont.capHeight / 2
                ]
                addAttributes(attributes, range: range)
            }
        }
        
        public func superscriptCents(currencySymbol symbol: String? = nil, fontName: String? = nil) {
            _ = try? superscript(pattern: "\(symbol ?? "")\\d+(\\.\\d{2})", fontName: fontName)
        }
    }
#endif

