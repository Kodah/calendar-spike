//
//  String+Tests.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 01/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class String_Tests: XCTestCase {
    
    func test_multiply_operator() {
        assert("i" * -1) == ""
        assert("i" * 0) == ""
        assert("i" * 1) == "i"
        assert("i" * 2) == "ii"
    }
    
    func test_lastPOSIXPathComponent() {
        assert("/tmp/scratch.tiff".lastPOSIXPathComponent) == "scratch.tiff"
        assert("/tmp/scratch".lastPOSIXPathComponent) == "scratch"
        assert("/tmp/".lastPOSIXPathComponent) == "tmp"
        assert("scratch///".lastPOSIXPathComponent) == "scratch"
        assert("/".lastPOSIXPathComponent) == "/"
        assert("//".lastPOSIXPathComponent) == "/"
        assert("///".lastPOSIXPathComponent) == "/"
        assert("".lastPOSIXPathComponent) == ""
    }
}
