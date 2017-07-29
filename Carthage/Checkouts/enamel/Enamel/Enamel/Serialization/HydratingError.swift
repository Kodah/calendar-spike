//
//  HydratingError.swift
//  Enamel
//
//  Created by milos on 04/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public struct HydratingError: Error, HasID {
    
    public let info: String?
    let type: Any.Type?
    let key: Any?
    let data: Any?
    let locationInCode: String
    
    public let id = ID()
    
    public init(
        info: String? = nil,
        type: Any.Type? = nil,
        key: Any? = nil,
        data: Any? = nil,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
    {
        self.info = info
        self.type = type
        self.key = key
        self.data = data
        self.locationInCode = path(function: function, file: file, line: line)
    }
}

// MARK:- Serialization

extension HydratingError: Dehydratable {
    
    public func dehydrate() -> [String:Any] {
        var $: [String:Any] = ["location": locationInCode]
        $["info"] = info
        $["type"] = type.map{ String(describing: $0) }
        $["key"] = key.map{ String(describing: $0) }
        $["data"] = (data as? NSDictionary) ?? data.map{ String(describing: $0) }
        return $
    }
}
