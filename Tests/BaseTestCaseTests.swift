// BaseTestCaseTests.swift Created by mason on 2016-05-07. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class BaseTestCaseTests: BaseTestCase {
    
    func test_asyncTestConveniences() {
        
        var x = "foo"
        
        beginAsyncSection()
        
        DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault).async {
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
