//  Request+AuthTests.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestAuthTests: BaseTestCase {

    /// Performs `auth` API operation, and verifies that a success response is returned that includes expected values. Requires actual API Sandbox credentials be stored in the Keychain.
    
    func test_auth_with_root_account() {
        
        guard let credentials = credentialsForTestUse(.RootAccount) else {
            // To store your credentials, set a breakpoint here and do this (see note in method documentation):
            // saveSandboxRootCredentials("foo", password: "bar")

            return
        }
        
        beginAsyncSection()
        
        Request.auth(credentials).run { (result) in
            
            print("AUTH: ", result)
            XCTAssert(result.error == nil)
            
            if let payload = result.payload {
                
                let authResponse = AuthResponse(payload)
                
                XCTAssertNotNil(authResponse)
                XCTAssertNotNil(authResponse?.operatorId)
                XCTAssertNotNil(authResponse?.apiKey)
                XCTAssertNotNil(authResponse?.token)
                
            } else {
                XCTFail("auth() did not receive a payload")
            }
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    
    // FIXME: add test for auth() with .AuthKey credentials
    // FIXME: add test for auth() with .SAM credentials
    
    
    /// Make a bogus request and assert the expected error happens.
    
    func test_issue_password_reset_token() {

        beginAsyncSection()
        
        Request.issuePasswordResetToken("fragnock@whut.com").run { (result) in
            
            XCTAssert(result.error != nil)
            XCTAssert(result.error?.code == "AUM0004")
            
            let message = result.error?.message ?? ""
            XCTAssert(message.containsString("nvalid email address"))
            
            print("\(result.error)" ?? "")
            print(result.text)
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
}
