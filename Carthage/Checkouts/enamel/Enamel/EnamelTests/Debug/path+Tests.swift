//
//  path+Tests.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 01/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class path_Tests: XCTestCase {
    
    func test_path() {
        assert(path()) == "test_path() in path+Tests.swift 14"
        
        let thatPath = path(
            function: "test_path()",
            file: "/Users/milos/Dropbox/sky/Enamel/EnamelTests/Debug/path+Tests.swift",
            line: 14
        )
        assert(thatPath) == "test_path() in path+Tests.swift 14"
    }
}
