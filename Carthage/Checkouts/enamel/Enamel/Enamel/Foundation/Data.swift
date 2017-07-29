//
//  NSData.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 02/10/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension Data {
    
    public func string(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    public func jsonDictionary(_ options: JSONSerialization.ReadingOptions = []) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: self, options: options)) as? [String: Any]
    }
    
    public func jsonArray(_ options: JSONSerialization.ReadingOptions = []) -> [[String: Any]]? {
        return (try? JSONSerialization.jsonObject(with: self, options: options)) as? [[String: Any]]
    }
    
    /// - note: `pretty` option incurs performance cost
    public func jsonString(_ options: JSONSerialization.ReadingOptions = [], pretty: Bool = false) -> String? {
        guard pretty else {
            return string()
        }
        guard
            let dictionary = jsonDictionary(),
            JSONSerialization.isValidJSONObject(dictionary),
            let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            else
        {
            return nil
        }
        return data.string()
    }
    
    public init?(json: [String: Any], options: JSONSerialization.WritingOptions = []) {
        guard JSONSerialization.isValidJSONObject(json) else {
            note("Not all objects are valid json objects in: \(json)")
            return nil
        }
        do {
            self = try JSONSerialization.data(withJSONObject: json, options: options)
        } catch {
            note("Json dictionary failed to serialize\n\tJSON: \(json)\n\tERROR: \(error)")
            return nil
        }
    }
}
