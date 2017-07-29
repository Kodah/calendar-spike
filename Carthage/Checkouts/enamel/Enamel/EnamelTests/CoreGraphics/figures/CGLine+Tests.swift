//
//  CGLine+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 01/02/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGLine_Tests: XCTestCase {

    func test_zero_length() {
        let line = CGLine.zero
        assert(line.length) ~= .zero ± 0.01
    }
}
