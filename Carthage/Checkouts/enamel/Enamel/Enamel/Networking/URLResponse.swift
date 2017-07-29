//
//  NSHTTPURLResponse.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 05/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public extension URLResponse {

    public var httpResponse: HTTPURLResponse? { return self as? HTTPURLResponse }
    
    public var cookies: [HTTPCookie] {
        guard
            let this = self as? HTTPURLResponse,
            let headers = this.allHeaderFields as? [String:String],
            let url = url
            else
        {
            return []
        }
        return HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
    }
    
    public func cookie(named name: String) -> HTTPCookie? {
        return cookies.first{ $0.name == name }
    }
}

public extension HTTPURLResponse {
    var isSuccess: Bool { return 200...299 ~= statusCode }
    var isRedirect: Bool { return 300...399 ~= statusCode }
    var isClientError: Bool { return 400...499 ~= statusCode }
    var isServerError: Bool { return 500...599 ~= statusCode }
}
