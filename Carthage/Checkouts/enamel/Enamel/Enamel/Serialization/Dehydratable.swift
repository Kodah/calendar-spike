//
//  Dehydratable.swift
//  Enamel
//
//  Created by Jon Cotton & Milos Rankovic on 02/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public protocol Dehydratable: CustomStringConvertible {
    
    func dehydrate() -> [String: Any] // TODO: consider parameter `ignoreNested: Bool = false`
}

extension Dehydratable {
    
    public var description: String {
        let string = jsonString(pretty: true) ?? "Not all objects are valid json objects"
        return "\(type(of: self)) dehydrated: \(string)"
    }
    
    /// - note: `pretty` option incurs performance cost
    public func jsonString(pretty: Bool = false) -> String? {
        return jsonData(pretty: pretty).flatMap{ $0.string() }
    }
    
    public func jsonData(pretty: Bool = false) -> Data? {
        return Data(json: dehydrate(), options: pretty ? .prettyPrinted : [])
    }
}

extension Sequence where Iterator.Element: Dehydratable {
    
    public func dehydrate() -> [[String: Any]] {
        return map{ $0.dehydrate() }
    }
}
