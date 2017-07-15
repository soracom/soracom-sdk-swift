//  Request+AuthTests.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif

class RequestAuthTests: BaseTestCase {

    /// Performs `auth` API operation, and verifies that a success response is returned that includes expected values. Requires actual API Sandbox credentials be stored in the Keychain.
    
    func test_auth_with_root_account() {
        
        let credentials = Client.sharedInstance.credentialsForSandboxUser
        
        guard !credentials.blank else {
            // API Sandbox user can be created automatically as needed, but only if production SAM user credentials have been stored. 
            // For the SDK demo apps, you can use the GUI to save these credentials; otherwise, you can do it in the debugger. See Client.doInitialHousekeeping() for details
            
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
            
            // Mason 2016-06-29: Observed API behavior change: previously err was AUM0004 but as of today looks like it is now AUM0015. For this test, I will just allow both, for now.
            
            XCTAssert(response.error != nil)
            
            guard let code = response.error?.code, let message = response.error?.message else {
                XCTFail("didn't get an error code &/or message ")
                return
            }
            
            XCTAssert(code == "AUM0004" || code == "AUM0015")
            XCTAssertNotNil(message)
            
            print("\(String(describing: response.error))")
            print(response.text ?? "(response.text == nil)")
            
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


#if os(Linux)
    extension RequestAuthTests {
        static var allTests : [(String, (RequestAuthTests) -> () throws -> Void)] {
            return [
                ("test_auth_with_root_account", test_auth_with_root_account),
                ("test_issue_password_reset_token", test_issue_password_reset_token),
                ("test_example_for_documentation", test_example_for_documentation),
            ]
        }
    }
#endif 

