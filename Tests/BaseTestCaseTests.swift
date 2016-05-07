// BaseTestCaseTests.swift Created by mason on 2016-05-07. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class BaseTestCaseTests: BaseTestCase {
    
    func test_asyncTestConveniences() {
        
        var x = "foo"
        
        beginAsyncSection()
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            x += "bar"
            NSThread.sleepForTimeInterval(0.001)
            x += "baz"
            NSThread.sleepForTimeInterval(0.001)
            x += "😬"
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        XCTAssert(x == "foobarbaz😬")
    }
    
}
