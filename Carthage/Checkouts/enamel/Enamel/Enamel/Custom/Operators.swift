//
//  Operators.swift
//  SwiftSky
//
//  Created by Rankovic, Milos (Developer) on 25/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Swift // ⌘-Click to consult Standard Library precendance groups

precedencegroup LeftApplyPrecedence {
    associativity: left
    higherThan: RightApplyPrecedence
    lowerThan: TernaryPrecedence
}

precedencegroup RightApplyPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
    lowerThan: TernaryPrecedence
}

infix operator § : RightApplyPrecedence // apply

infix operator |> : LeftApplyPrecedence // pipe forward

infix operator |>> : LeftApplyPrecedence // pipe & map forward

infix operator %== : ComparisonPrecedence // divisible by

infix operator ??^ : NilCoalescingPrecedence // unwrap or throw

infix operator ??! : NilCoalescingPrecedence // force unwrap in DEBUG, else default value
