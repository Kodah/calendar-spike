//
//  Foundation+Debug.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 02/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public extension String {
    
    public init(
        from data: Data?,
        _ response: URLResponse?,
        _ error: Error?,
        _ message: String = "RESPONSE LOG")
    {
        var o: [String] = ["\(message):"]
        if let data = data {
            o.append("DATA: \(data.jsonString() ?? data.string() ?? data.debugDescription)")
        }
        if let response = response {
            o.append("HTTP RESPONSE: \(response)")
        }
        if let error = error {
            o.append("ERROR: \(error.localizedDescription)")
        }
        self = o.joined(separator: "\n\t")
    }
}
