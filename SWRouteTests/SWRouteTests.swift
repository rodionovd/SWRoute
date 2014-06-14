//
//  SWRouteTests.swift
//  SWRouteTests
//
//  Created by Dmitry Rodionov on 6/15/14.
//  Copyright (c) 2014 rodionovd. All rights reserved.
//

import XCTest
import SWRoute

class DemoClass {
    func demoMethod(arg: Int) -> Int {
        return (42 + arg);
    }
}

class SWRouteTests: XCTestCase {

    func testSWRoute() {

        /* Preconditions */
        let arg = 13
        XCTAssert(DemoClass().demoMethod(arg) == (42 + arg), "", file: __FILE__, line: __LINE__)

        /*
        * Replacing the method with a custom closure
        */
        var err = SwiftRoute.replace(function: DemoClass().demoMethod, with: {
            (arg : Int) -> Int in
            return (90 + arg)
            })
        XCTAssert(err == Int(KERN_SUCCESS), "", file: __FILE__, line: __LINE__)
        XCTAssert(DemoClass().demoMethod(arg) == (90 + arg), "", file: __FILE__, line: __LINE__)

        /*
        * Replacing the method with a function
        */
        func replacement(arg : Int) -> Int {
            return (567 - arg);
        }
        err = SwiftRoute.replace(function: DemoClass().demoMethod, with: replacement)
        XCTAssert(err == Int(KERN_SUCCESS), "", file: __FILE__, line: __LINE__)
        XCTAssert(DemoClass().demoMethod(arg) == (567 - arg), "", file: __FILE__, line: __LINE__)

        /*
        * Replacing a function with another function
        */
        func target(arg : Int) -> Int {
            return 0;
        }
        err = SwiftRoute.replace(function: target, with: replacement)
        XCTAssert(err == Int(KERN_SUCCESS), "", file: __FILE__, line: __LINE__)
        XCTAssert(target(arg) == (567 - arg), "", file: __FILE__, line: __LINE__)
    }
}
