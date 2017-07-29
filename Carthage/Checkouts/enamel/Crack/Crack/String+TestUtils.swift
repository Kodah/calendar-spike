//
//  String+TestUtils.swift
//  State
//
//  Created by Rankovic, Milos (Developer) on 13/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension String {
    
    public func siren(in
        bundle: Bundle? = RunningTestBundle,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> Siren
    {
        let data = json(in: bundle, function: function, file: file, line: line)
        do {
            return try Siren(source: data)
        } catch {
            let msg = "Failed to parse siren-json from file '\(withoutJSONFileExtension)'.json with error: \(error)"
            fatal(msg, function: function, file: file, line: line)
        }
    }
    
    public func json(in
        bundle: Bundle? = RunningTestBundle,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> [String:Any]
    {
        let data = (self.withoutJSONFileExtension + ".json")
            .file(in: bundle, function: function, file: file, line: line)
        
        let x = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let json = x as? [String:Any] else {
            let msg = "🚫 Could not deserialise as json the file '\(self.withoutJSONFileExtension).json'"
            fatal(msg, function: function, file: file, line: line)
        }
        return json
    }
}

public extension String {
        
    public func file(in
        bundle: Bundle? = RunningTestBundle,
        function: String = #function,
        file: String = #file,
        line: Int = #line)
        -> Data
    {
        guard let bundle = bundle else {
            let msg = "⁉️ File not found: '\(self)' - NOTE: outside a test method you need to specify the bundle."
            fatal(msg, function: function, file: file, line: line)
        }
        guard
            let url = bundle.url(forResource: self, withExtension: ""),
            let o = try? Data(contentsOf: url, options: .uncached)
            else
        {
            let msg = "⁉️ File not found: '\(self)'"
            fatal(msg, function: function, file: file, line: line)
        }
        return o
    }
}

// MARK:- utils

fileprivate extension String {
    
    var withoutJSONFileExtension: String {
        guard hasSuffix(".json") else { return self }
        return substring(to: index(endIndex, offsetBy: -5))
    }
}
