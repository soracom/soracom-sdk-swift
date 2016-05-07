// APIOperationTests.swift Created by mason on 2016-04-25. Copyright © 2016 masonmark.com. All rights reserved.

import XCTest

class APIOperationTests: BaseTestCase {
    
    var bogusCreds: SoracomCredentials {
        return SoracomCredentials(type: .RootAccount, emailAddress: "bogus", password: "bogus")
    }
    
    var bogusAuthRequest: Request {
        return Request.auth(bogusCreds)
    }

    func test_basic() {
        
        // This just tests that APIOperation can run a request and that the completion handler gets executed.
        
        var testValue        = 0
        var error: APIError? = nil
        let request          = bogusAuthRequest
        
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
    
    
    func test_deferred_operation() {
        
        // Test that we can create an APIOperation that defers creating its Request until it is executed, so that it can depend on the result of an earlier operation.
        
        beginAsyncSection()

        let COM0008 = "COM0008"
          // Because req is bogus, COM0008 error should be returned ('not a well-formed email address'). We will use this.
        
        var values: [String] = []
        
        // OK, first let's build up the second operation, which will depend on the first. IRL, it would make more sense
        // to do something like authenticate and capture a token, then use that token to do something. But to keep the
        // test simple, I am just going to attempt a bogus login and capture the error code.
        
        let requestBuilder: RequestBuilder = { () in
            
            let valFromFuture = values.last ?? "test bug"
            XCTAssert(valFromFuture == COM0008)
            
            let credentialsBasedOnPreviousOperation = SoracomCredentials(type: .RootAccount, emailAddress: valFromFuture, password: valFromFuture)
            
            return Request.auth(credentialsBasedOnPreviousOperation)
        }
        
        let responseHandler = { (response: Response) in
            
            values.append("second operation did run")
            
            let payload = response.request.requestPayload
            
            if let email    = payload?[.email] as? String,
               let password = payload?[.password] as? String
            {
                XCTAssert(email == COM0008)
                XCTAssert(password == COM0008)
            } else {
                XCTFail("Operation's request should have used value from previous requedt for email and password. (Instead: \(payload)")
            }
            self.endAsyncSection()
        }
        
        let opThatDependsOnPredecessor = APIOperation(requestBuilder, completionHandler: responseHandler)
        
        let opThatRunsFirst = APIOperation(bogusAuthRequest) { (response) in
            let valueCapturedFromFirstOperation = response.error?.code ?? "test bug"
            values.append(valueCapturedFromFirstOperation)
        }
        
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations([opThatRunsFirst, opThatDependsOnPredecessor], waitUntilFinished: false)
        
        waitForAsyncSection()
        
        XCTAssertEqual(values, [COM0008, "second operation did run"])
    }
    
}
