//
//  CGRectGroup.swift
//  Enamel
//
//  Created by Rankovic, Milos (Developer) on 08/03/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGRectGroup_Tests: XCTestCase {
    
    func test_size() {
        let group = CGRectGroup(
            aligning: .bottom(.center),
            sizes: 10.of{ CGSize.unit },
            padding: 1,
            spacing: 1
        )
        assert(group.size) ~= CGSize(width: 3, height: 21) ± 0.1
    }
    
    func test_size_of_empty_group() {
        let group = CGRectGroup(
            aligning: .bottom(.center),
            sizes: [],
            padding: 1,
            spacing: 1
        )
        assert(group.size) ~= CGSize(width: 2, height: 2) ± 0.1
    }
}
