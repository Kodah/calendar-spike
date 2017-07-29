//
//  Siren.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 09/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct Siren {
    
    public typealias Entity = Siren
    
    public struct Action {
        public let name: String
        public let fields: [Field]
    }
    
    public struct Field {
        public let name: String
        public let type: FieldType
        public let value: Any?
        // TODO: dependson?
    }
    
    public enum FieldType: String {
        
        // see: https://github.com/kevinswiber/siren#type-3
        case hidden, text, search, tel, url, email, password
        case datetime, date, month, week, time, datetime_local
        case number, range, color, checkbox, radio, file
        
        // `select` and `captcha` are not HTML 5 input types: https://www.w3.org/TR/html5/single-page.html#attr-input-type
        case select, captcha
        
        public var string: String {
            return rawValue.replacingOccurrences(of: "_", with: "-")
        }
        
        public init?(string: String) {
            self.init(rawValue: string.replacingOccurrences(of: "-", with: "_"))
        }
    }
    
    public let classes: Set<String>
    public let entities: [Entity]
    public let properties: [String:Any]
    public let actions: [Action]
    
    public func everyEntity(classed firstClass: String, restOfClasses: String...) -> [Entity] {
        let classes = [firstClass] + restOfClasses
        return entities.filter{ $0.classes.isSuperset(of: classes) }
    }
    
    public func entity(classed firstClass: String, restOfClasses: String...) -> Entity? {
        let classes = [firstClass] + restOfClasses
        return entities.first{ $0.classes.isSuperset(of: classes) }
    }
    
    public func action(named name: String) -> Action? {
        return actions.first{ $0.name == name }
    }
    
    public func property(_ name: String) -> Any? { // hydrating will get you further
        return properties[name]
    }
    
    public subscript(propertyName: String) -> Any? { // hydrating will get you further
        return property(propertyName)
    }
}

extension Siren: Hydratable {
    
    public static func hydrate(_ hydrated: inout Siren?, source data: [String : Any]) throws {
        hydrated = Siren(
            classes: data.hydrate("class", else: []),
            entities: data.hydrate("entities", else: []),
            properties: data.hydrate("properties", else: [:]),
            actions: data.hydrate("actions", else: [])
        )
    }
}

extension Siren.Action: Hydratable {
    
    public static func hydrate(_ hydrated: inout Siren.Action?, source data: [String : Any]) throws {
        hydrated = Siren.Action(
            name: try data.hydrate("name"),
            fields: data.hydrate("fields", else: [])
        )
    }
}

extension Siren.Field: Hydratable {
    
    public static func hydrate(_ hydrated: inout Siren.Field?, source data: [String : Any]) throws {
        hydrated = Siren.Field(
            name: try data.hydrate("name"),
            type: data.hydrate("type", else: .text, transform: { Siren.FieldType(string: $0) }),
            value: data.hydrate("value", else: nil)
        )
    }
}
