//
//  note.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 13/09/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

// MARK:- note

public func note(
    function: String = #function,
    file: String = #file,
    line: Int = #line)
{
    #if DEBUG
        note("", function: function, file: file, line: line)
    #endif
}

public func note<T>(
    _ autoclosure: @autoclosure () -> T,
    function: String = #function,
    file: String = #file,
    line: Int = #line)
{
    #if DEBUG
        let message = "\(autoclosure())"
        if message.isEmpty {
            print(
                function,
                "←",
                file.lastPOSIXPathComponent,
                line
            )
        } else {
            print(
                message,
                "←",
                function,
                "in",
                file.lastPOSIXPathComponent,
                line
            )
        }
    #endif
}
