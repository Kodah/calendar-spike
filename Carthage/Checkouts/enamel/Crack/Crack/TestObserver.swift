//
//  TestObserver.swift
//  State
//
//  Created by Rankovic, Milos (Developer) on 01/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

private(set) var RunningTestBundle: Bundle?
private(set) var RunningTestCase: XCTestCase?

final class TestObserver: NSObject, XCTestObservation {
    
    fileprivate static func start() { singleton.start() }
    private func start() {}
    
    private static let singleton = TestObserver()
    
    private override init() {
        super.init()
        XCTestObservationCenter.shared().addTestObserver(self)
    }
    
    func testBundleWillStart(_ testBundle: Bundle) {
        RunningTestBundle = testBundle
    }
    
    func testBundleDidFinish(_ testBundle: Bundle) {
        RunningTestBundle = nil
    }
    
    @objc
    func testCaseWillStart(_ testCase: XCTestCase) {
        RunningTestCase = testCase
    }
    
    @objc
    func testCaseDidFinish(_: XCTestCase) {
        RunningTestCase = nil
    }
}

extension XCTestObservationCenter {
    
    override open class func initialize() {
        TestObserver.start()
        super.initialize()
    }
}
