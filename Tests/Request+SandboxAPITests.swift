// Request+SandboxAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestSandboxAPITests: BaseTestCase {
    
    
    func test_getSignupToken_bad_credentials() {
    
        let uniqueEmail = "\(NSUUID().UUIDString)@fivespeed.com"
        let badRequest  = Request.getSignupToken(email: uniqueEmail, authKeyId: "this-is-wrong", authKey: "this-is-also-wrong")
        
        beginAsyncSection()
        
        badRequest.run { (response) in
            
            print(response)
            XCTAssertNotNil(response.error)
            
            let code = response.error?.code ?? "no code"
            XCTAssert(code.containsString("SBX"))
              // Just assert it is some kind of sandbox error.
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    
    func test_createOperator_then_getSignupToken() {
        
        // For this test, we need the credentials for a SAM user from the real production environment.
        
        guard let credentials = credentialsForTestUse(.AuthKey, production: true) else {
            // To add credentials, set a breakpoint here and do this (see notes in method documentation):
            // saveProductionAuthKeyCredentialsForTests(authKeyID: "xxxxxx", authKeySecret: "xxxxxx")
            
            print ("skipping \(#function) because no credentials are available.")
            return
        }
        
        self.continueAfterFailure = false
        
        let uniqueEmail    = "\(NSUUID().UUIDString)@fivespeed.com"
        let uniquePassword = "(NSUUID().UUIDString)a$d5555"
        
        
        // CREATE THE OPERATOR:
        
        beginAsyncSection()
        
        Request.createOperator(uniqueEmail, password: uniquePassword).run { (response) in
            
            print(response)
            
            XCTAssertNil(response.error)
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
       
        // AUTHORIZE CREATION OF, AND CREATE, A SIGNUP TOKEN:
        
        let req = Request.getSignupToken(email: uniqueEmail, authKeyId: credentials.authKeyID, authKey: credentials.authKeySecret)
        
        beginAsyncSection()

        req.run { (response) in
            print(response)
            
            XCTAssertNil(response.error)
            
            let token = response.payload?[.token]
            XCTAssertNotNil(token)
            
            self.endAsyncSection()
            
            // One possibility: {"code":"SBX1003","message":"Unable to get verified one time token. please create an user at first"}】
        }
        waitForAsyncSection()
        
    }
    
}
