//
//  NSAttributedString.swift
//  SwiftSkyUI
//
//  Created by milos on 20/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Enamel
import UIKit

public extension NSAttributedString {
    
    public convenience init(string: String, attributes: NSStringAttribute...) {
        self.init(string: string, attributes: attributes.dictionary)
    }
    
    public convenience init(string: String, attributes: NSStringAttributeType...) {
        self.init(string: string, attributes: attributes.dictionary)
    }
    
    public convenience init<Attributes>(string: String, attributes: Attributes)
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttribute
    {
        self.init(string: string, attributes: attributes.dictionary)
    }
    
    public convenience init<Attributes>(string: String, attributes: Attributes)
        where
        Attributes: Sequence,
        Attributes.Iterator.Element == NSStringAttributeType
    {
        self.init(string: string, attributes: attributes.dictionary)
    }
}

