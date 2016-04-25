// APIOperationTests.swift Created by mason on 2016-04-25. Copyright © 2016 masonmark.com. All rights reserved.

import XCTest

class APIOperationTests: BaseTestCase {

    func test_basic() {
        
        // This just tests that APIOperation can run a request and that the completion handler gets executed.
        
        var testValue = 0
        var error: APIError? = nil
        
        let bogusCreds = SoracomCredentials(type: .RootAccount, emailAddress: "bogus", password: "bogus")
        let request    = Request.auth(bogusCreds)
        
        beginAsyncSection()
        
        let op = APIOperation(request) { (response) in
            
            testValue = 5
            error     = response.error
            
            self.endAsyncSection()
        }
        
        let queue = NSOperationQueue()
        queue.addOperation(op)
        
        waitForAsyncSection()
        
        XCTAssert(testValue == 5)
        XCTAssert(error != nil)
    }
    
}
