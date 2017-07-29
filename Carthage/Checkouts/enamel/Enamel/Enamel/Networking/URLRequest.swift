//
//  NSURLRequest.swift
//  Enamel
//
//  Created by Milos (Developer) on 06/12/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    public var path: String? { return url?.path }
    public var lastPathComponent: String? { return url?.lastPathComponent }
}
