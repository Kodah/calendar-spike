//
//  CGCircle+Tests.swift
//  Enamel
//
//  Created by Jung, Matthew (Associate Software Developer) on 30/01/2017.
//  Copyright © 2017 Sky. All rights reserved.
//

import Crack

class CGCircle_Tests: XCTestCase {

    // MARK:- With
    
    func test_circle_with_updates_circle() {
        let circle = CGCircle(center: .zero, radius: 10)
        let newCircle = circle.with(center: CGPoint(x: 1, y: 1), radius: 5)
        
        assert(newCircle.radius) ~= 5 ± 0.01
        assert(newCircle.center) ~= CGPoint(x: 1, y: 1) ± 0.01
    }
    
    // MARK:- Scaled
    
    func test_circle_scaled_by_decimal() {
        let circle = CGCircle(center: .zero, radius: 10)
        let newCircle = circle.scaled(by: 0.5)
        assert(newCircle.radius) == 10 * 0.5
    }
    
    func test_circle_scaled_by_negative() {
        let circle = CGCircle(center: .zero, radius: 10)
        let newCircle = circle.scaled(by: -2)
        assert(newCircle.radius) ~= 10 * -2 ± 0.01
    }
    
    func test_circle_scaled_by_zero() {
        let circle = CGCircle(center: .zero, radius: 10)
        
        let newCircle = circle.scaled(by: 0)
        assert(newCircle.radius) ~= .zero ± 0.01
    }
    
    // MARK:- Resized
    
    func test_circle_resized() {
        let circle = CGCircle(center: .zero, radius: 10)
        let positivelyResizedCircle = circle.resized(by: 10)
        let negativelyResizedCircle = circle.resized(by: -10)

        assert(positivelyResizedCircle.radius) ~= 10 + 10 ± 0.01
        assert(negativelyResizedCircle.radius) ~= .zero ± 0.01
    }
    
    // MARK:- Equatable

    func test_circle_equatable_radius() {
        let circle = CGCircle(center: .zero, radius: 10)
        var newCircle = CGCircle(center: .zero, radius: 10)
        assert(newCircle == circle) == true
        
        newCircle.radius = 5
        assert(newCircle == circle) == false
    }
    
    func test_circle_equatable_center() {
        let circle = CGCircle(center: .zero, radius: 10)
        var newCircle = CGCircle(center: .zero, radius: 10)
        assert(newCircle == circle) == true

        newCircle.center = CGPoint(x: 2, y: 2)
        assert(newCircle == circle) == false
    }

    // MARK:- Point atAngle
    
    func test_circle_point_atAngle_zero() {
        let circle = CGCircle(center: .zero, radius: 10)
        
        let minusNinetyPoint = circle.point(atAngle: -90.degrees)
        assert(minusNinetyPoint) ~= circle.center.offsetBy(dx: 0, dy: -10) ± 0.01
        
        let zeroPoint = circle.point(atAngle: 0.degrees)
        assert(zeroPoint) ~= circle.center.offsetBy(dx: 10, dy: 0) ± 0.01
        
        let threeSixtyPoint = circle.point(atAngle: 360.degrees)
        assert(threeSixtyPoint) ~= circle.center.offsetBy(dx: 10, dy: 0) ± 0.01
    }

    // MARK:- Description

    func test_circle_description() {
        let circle = CGCircle(center: .zero, radius: 10)
        
        let description = circle.description
        assert(description) ==  "CGCircle(center: \(CGPoint.zero), radius: \(10.cg))"
    }
}
