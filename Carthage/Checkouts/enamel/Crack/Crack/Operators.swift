//
//  Operators.swift
//  State
//
//  Created by Rankovic, Milos (Developer) on 03/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public func == <T: Equatable> (lhs: Asserted<T>, rhs: T) { if lhs.value == rhs { return }; fail(lhs, rhs) }
public func != <T: Equatable> (lhs: Asserted<T>, rhs: T) { if lhs.value != rhs { return }; fail(lhs, rhs) }

public func == <T: Equatable> (lhs: Asserted<[T]>, rhs: [T]) { if lhs.value == rhs { return }; fail(lhs, rhs) }
public func != <T: Equatable> (lhs: Asserted<[T]>, rhs: [T]) { if lhs.value != rhs { return }; fail(lhs, rhs) }

public func == <T: Equatable> (lhs: Asserted<T?>, rhs: T?) { if lhs.value == rhs { return }; fail(lhs, rhs) }
public func != <T: Equatable> (lhs: Asserted<T?>, rhs: T?) { if lhs.value != rhs { return }; fail(lhs, rhs) }

public func < <T: Comparable> (lhs: Asserted<T>, rhs: T) { if lhs.value < rhs { return }; fail(lhs, rhs) }
public func <= <T: Comparable> (lhs: Asserted<T>, rhs: T) { if lhs.value <= rhs { return }; fail(lhs, rhs) }
public func > <T: Comparable> (lhs: Asserted<T>, rhs: T) { if lhs.value > rhs { return }; fail(lhs, rhs) }
public func >= <T: Comparable> (lhs: Asserted<T>, rhs: T) { if lhs.value >= rhs { return }; fail(lhs, rhs) }
