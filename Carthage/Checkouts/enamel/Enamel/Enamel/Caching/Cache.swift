//
//  NSCache.swift
//  Enamel
//
//  Created by Prescott, Ste on 04/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public protocol Cachable {
    var key: String { get }
    var cost: Int { get }
}

public protocol Cache {
    associatedtype Item: Cachable
    static func add(_: Item, key: String?)
    static func get(by key: String) -> Item?
    static func clear()
}

public extension Cache {
    
    public static func get(by key: String, else create: @autoclosure () -> Item?) -> Item? {
        return get(by: key) ?? create()
    }
    
    public static func get(by key: String, else create: @autoclosure () -> Item) -> Item {
        return get(by: key) ?? create()
    }
}
