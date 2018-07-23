// BaseTestCaseTests.swift Created by mason on 2016-05-07. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    import Dispatch
    #if !SKIP_TESTABLE_IMPORT_FOR_TESTS
@testable import SoracomAPI
#endif
#endif

class BaseTestCaseTests: BaseTestCase {
    
    func test_asyncTestConveniences() {
        
        var x = "foo"
        
        beginAsyncSection()
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            x += "bar"
            Thread.sleep(forTimeInterval: 0.001)
            x += "baz"
            Thread.sleep(forTimeInterval: 0.001)
            x += "😬"
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        XCTAssert(x == "foobarbaz😬")
    }
    
}

extension BaseTestCaseTests {
    
    static var allTests : [(String, (BaseTestCaseTests) -> () throws -> Void)] {
        return [
            ("test_asyncTestConveniences", test_asyncTestConveniences),
        ]
    }
}
