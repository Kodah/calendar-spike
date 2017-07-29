//
//  Hydratable.swift
//  Enamel
//
//  Created by Jon Cotton & Milos Rankovic on 02/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public protocol Hydratable {
    static func hydrate(_ hydrated: inout Self?, source data: [String:Any]) throws
}

public extension Hydratable {
    
    public init(source data: [String:Any]) throws {
        var o: Self?
        try Self.hydrate(&o, source: data)
        self = try o ??^ HydratingError(type: Self.self, data: data)
    }
}

// MARK:- Testing utilities

public extension Hydratable where Self: Dehydratable {
    
    public var hydratedDehydratedSelf: Self? {
        let data = self.dehydrate()
        do {
            return try Self.init(source: data)
        }
        catch {
            print(
                "---------------------------------------------------------\n",
                "<\(type(of: self))>.\(#function) error: \(error)\n",
                path(),
                "\n---------------------------------------------------------\n"
            )
            return nil
        }
    }
}


