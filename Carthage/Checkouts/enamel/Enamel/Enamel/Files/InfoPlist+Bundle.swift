//
//  Bundle.swift
//  Enamel
//
//  Created by Cotton, Jonathan (Mobile Developer) on 07/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension Bundle {
    
    #if DEBUG
    public static var mockInfoPlist: InfoPlist?
    
    @available(*, unavailable, renamed: "mockInfoPlist")
    public static func set(mock: InfoPlist?) {}
    #endif

    public var info: InfoPlist? {
        
        #if DEBUG
        if let o = Bundle.mockInfoPlist {
            note("Using mock InfoPlist \(o)")
            return o
        }
        #endif

        return try? InfoPlist(in: self)
    }
}
