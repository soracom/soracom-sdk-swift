// OrdersTests.swift Created by mason on 2018-08-28. Copyright © 2018 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif


class OrdersTests: XCTestCase {
    
    
    func test_basic() {
        
        XCTAssert(1 == 1)
    }
}

#if os(Linux)
extension OrdersTests {
    static var allTests : [(String, (OrdersTests) -> () throws -> Void)] {
        return [
            ("test_basic", test_basic),
        ]
    }
}
#endif

