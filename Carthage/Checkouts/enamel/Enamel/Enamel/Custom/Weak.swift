//
//  Weak.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 16/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct Weak<Object: AnyObject>: WeakProtocol {
    
    public let id: ObjectIdentifier
    public private(set) weak var object: Object?
    
    public init(_ object: Object) {
        id = ObjectIdentifier(object)
        self.object = object
    }
}

public extension Weak {
    
    public var type: Object.Type { return Object.self }
}

public protocol WeakProtocol: Hashable {
    associatedtype Object: AnyObject
    
    var id: ObjectIdentifier { get }
    var object: Object? { get }
    var hashValue: Int { get }
    init(_ object: Object)
    static func == (lhs: Self, rhs: Self) -> Bool
}

public extension WeakProtocol {
    
    public var hashValue: Int { return id.hashValue }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Set where Element: WeakProtocol {
    
    public func contains(_ member: Element.Object) -> Bool {
        let id = ObjectIdentifier(member)
        return contains(where: { $0.id == id })
    }
    
    @discardableResult
    public mutating func insert(_ newMember: Element.Object) -> (inserted: Bool, memberAfterInsert: Element) {
        return insert(Element(newMember))
    }
    
    @discardableResult
    public mutating func remove(_ member: Element.Object) -> Element? {
        return remove(Element(member))
    }
}
