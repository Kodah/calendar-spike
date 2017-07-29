//
//  Label+CanLayout.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 23/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// FIXME: Wrong place for this as it involves Foundation

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public protocol LabelLayoutType {
    var frame: CGRect { get set }
    var attributedText: NSAttributedString? { get set }
}

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
extension Label: CanLayout {
    
    public func layout(in rect: CGRect) -> Self {
        frame = rect
        guard let text = attributedText else { return self }
        attributedText = text.resized(toFit: self.frame.size)
        return self
    }
}

/// Fundamental layout for label types (i.e. to be composed into more complex layouts)
@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public struct FitLabelLayout<Label: LabelLayoutType>: CanLayout {
    
    public var label: Label
    public var alignment: CGNamedPoint
    
    public init(label: Label, alignment: CGNamedPoint) {
        self.label = label
        self.alignment = alignment
    }
    
    public func layout(in rect: CGRect) -> FitLabelLayout {
        var $ = self
        guard var text = label.attributedText else {
            $.label.frame = rect
            return self
        }
        text = text.resized(toFit: rect.size)
        $.label.frame = CGRect(
            anchor: alignment.anchor,
            position: rect.point(atAnchor: alignment.anchor),
            size: text.size()
        )
        $.label.attributedText = text
        return $
    }
}

@available(*, deprecated, message: "Will be removed in future release of Enamel.")
public struct TitleSubtitleDivideLayout<Title: LabelLayoutType, Subtitle: LabelLayoutType>: CanLayout {
    
    public var title: Title
    public var subtitle: Subtitle
    public var sizeRatio: CGFloat
    public var padding: CGFloat
    public var spacing: CGFloat
    
    public init(
        title: Title,
        subtitle: Subtitle,
        sizeRatio: CGFloat = 0.6,
        padding: CGFloat = 0,
        spacing: CGFloat = 0)
    {
        self.title = title
        self.subtitle = subtitle
        self.sizeRatio = (0...1).clamp(sizeRatio)
        self.padding = padding
        self.spacing = spacing
    }
    
    public func layout(in rect: CGRect) -> TitleSubtitleDivideLayout {
        DivideLayout(
            slice: FitLabelLayout(label: title, alignment: .bottomCenter),
            rest: FitLabelLayout(label: subtitle, alignment: .topCenter),
            distance: sizeRatio * rect.height,
            edge: .top,
            padding: padding,
            spacing: spacing
        ).layout(in: rect)
        return self
    }
}

#if os(iOS)
    
    import UIKit
    
    public typealias Label = UILabel
    
    @available(*, deprecated, message: "Will be removed in future release of Enamel.")
    extension UILabel: LabelLayoutType {}
    
#elseif os(OSX)
    
    import AppKit
    
    public typealias Label = NSTextField

    @available(*, deprecated, message: "Will be removed in future release of Enamel.")
    extension NSTextField: LabelLayoutType {
        public var attributedText: NSAttributedString? {
            get { return attributedStringValue }
            set { attributedStringValue = newValue ?? NSAttributedString() }
        }
    }
#endif













