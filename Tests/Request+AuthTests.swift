//  Request+AuthTests.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestAuthTests: BaseTestCase {

    /// Performs `auth` API operation, and verifies that a success response is returned that includes expected values. Requires actual API Sandbox credentials be stored in the Keychain.
    
    func test_auth_with_root_account() {
        
        let credentials = SoracomCredentials.sandboxCredentials
        
        guard !credentials.blank else {
            // To store your credentials, set a breakpoint here and do this (see note in method documentation):
            // saveSandboxRootCredentials("foo", password: "bar")

            XCTFail("Cannot run \(#function) because no credentials are available. See comments in test method.")
            
            return
        }
        
        beginAsyncSection()
        
        Request.auth(credentials).run { (response) in
            
            print("AUTH: ", response)
            XCTAssert(response.error == nil)
            
            if let payload = response.payload {
                
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
        
        Request.issuePasswordResetToken("fragnock@whut.com").run { (response) in
            
            XCTAssert(response.error != nil)
            XCTAssert(response.error?.code == "AUM0004")
            
            let message = response.error?.message ?? ""
            XCTAssert(message.containsString("nvalid email address"))
            
            print("\(response.error)" ?? "")
            print(response.text)
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    func test_example_for_documentation() {
        
        // Mason 2016-05-14: This code is used as an example in README.md 
        
        beginAsyncSection()

        let req = Request.issuePasswordResetToken("bob@example.com")
        
        req.responseHandler = { (response) in
            
            if let error = response.error {
                print("😞 Failed to issue token: \(error)" )
            } else {
                print("😁 Token issued successfully!" )
                // do something with the token...
            }
            self.endAsyncSection()
        }
        
        req.run()

        waitForAsyncSection()

    }
    
}
