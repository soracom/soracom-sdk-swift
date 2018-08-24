// APIOperationTests.swift Created by mason on 2016-04-25. Copyright © 2016 Soracom, Inc.. All rights reserved.

import XCTest

@testable import SoracomAPI


class APIOperationTests: BaseTestCase {
    
    var bogusCreds: SoracomCredentials {
        return SoracomCredentials(type: .RootAccount, emailAddress: "bogus", password: "bogus")
    }

    
    func test_basic() {
        
        // This just tests that APIOperation can run a request and that the completion handler gets executed.
        
        var testValue        = 0
        var error: APIError? = nil
        let request          = Request.auth(bogusCreds) { (response) in
            
            testValue = 5
            error     = response.error
            
            self.endAsyncSection()
        }
        
        beginAsyncSection()
        
        let op = APIOperation(request)
        let queue = OperationQueue()
        queue.addOperation(op)
        
        waitForAsyncSection()
        
        XCTAssert(testValue == 5)
        XCTAssert(error != nil)
    }
    
    
    func test_deferred_operation() {
        
        // Test that we can create an APIOperation that defers creating its Request until it is executed, so that it can depend on the result of an earlier operation.
        
        beginAsyncSection()

        let COM0008 = "COM0008"
          // Because the first request is bogus, COM0008 error should be returned ('not a well-formed email address'). We will use this.
        
        var values: [String] = []
        
        // OK, first let's build up the second operation, which will depend on the first. IRL, it would make more sense
        // to do something like authenticate and capture a token, then use that token to do something. But to keep the
        // test simple, I am just going to attempt a bogus login and capture the error code.
        
        let opThatDependsOnPredecessor = APIOperation() {
            
            let valFromFuture = values.last ?? "test bug"
            XCTAssertEqual(valFromFuture, COM0008)
            
            // create fake creds that use the value from the first op as the email/password:
            let credentialsBasedOnPreviousOperation = SoracomCredentials(type: .RootAccount, emailAddress: valFromFuture, password: valFromFuture)
            
            return Request.auth(credentialsBasedOnPreviousOperation) { (response: Response) in
                
                
                values.append("second operation did run")
                
                let foo = response.request.credentials
                print(foo)
                
                guard let rehydratedCredentials = AuthRequest.from(response.request.messageBody) else {
                    XCTFail()
                    self.endAsyncSection()
                    return;
                }
                
                XCTAssertEqual(rehydratedCredentials.email, COM0008)
                XCTAssertEqual(rehydratedCredentials.password, COM0008)
                self.endAsyncSection()
            }

        }
        
        // Now let's build the first request operation, which is simple and doesn't depend on anything:
        let bogusAuthRequest = Request.auth(bogusCreds) { (response) in
            let valueCapturedFromFirstOperation = response.error?.code ?? "test bug"
            values.append(valueCapturedFromFirstOperation)
        }

        let opThatRunsFirst = APIOperation(bogusAuthRequest)
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperations([opThatRunsFirst, opThatDependsOnPredecessor], waitUntilFinished: false)
        
        waitForAsyncSection()
        
        XCTAssertEqual(values, [COM0008, "second operation did run"])
    }
    
}

#if os(Linux)
    extension APIOperationTests {
        static var allTests : [(String, (APIOperationTests) -> () throws -> Void)] {
            return [
                ("test_basic", test_basic),
                ("test_deferred_operation", test_deferred_operation),
            ]
        }
    }
#endif 

