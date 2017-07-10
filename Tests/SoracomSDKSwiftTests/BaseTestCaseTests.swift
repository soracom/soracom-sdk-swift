// BaseTestCaseTests.swift Created by mason on 2016-05-07. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    import Dispatch
    @testable import SoracomSDKSwift
#endif

class BaseTestCaseTests: BaseTestCase {
    
    func areEqual(lhs: [String:Any], rhs: [String:Any]) -> Bool {
        return false;
    }
    
    
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
    
    
    func test_isEquivalentJSON() {
        let yep  = isEquivalentJSON("{\"a\":[], \"b\": {}}", "{\"b\":    {}, \"a\":    []}")
        let nope = isEquivalentJSON("{\"a\":[]}", "{\"a\": {}}")
        XCTAssertTrue(yep)
        XCTAssertFalse(nope)
    }
    
}

extension BaseTestCaseTests {
    
    static var allTests : [(String, (BaseTestCaseTests) -> () throws -> Void)] {
        return [
            ("test_asyncTestConveniences", test_asyncTestConveniences),
            ("test_isEquivalentJSON", test_isEquivalentJSON),
        ]
    }
}
