//
//  path.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 02/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

public func path(
    function: String = #function,
    file: String = #file,
    line: Int = #line)
    -> String
{
    return "\(function) in \(file.lastPOSIXPathComponent) \(line)"
}
