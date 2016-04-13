//  Request+AuthTests.swift Created by mason on 2016-03-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestAuthTests: BaseTestCase {

    /// Performs `auth` API operation, and verifies that a success response is returned that includes expected values. Requires actual API Sandbox credentials be stored in the Keychain.
    
    func test_auth_with_root_account() {
        
        let credentials = SoracomCredentials(withStoredType: .RootAccount, namespace: storageNamespaceForTestCredentials)
        
        if credentials.emailAddress == "" {
            print("")
            print("TEST CREDENTIALS FOR API SANDBOX NOT FOUND.")
            print("This means that \(#function) will not execute.")
            print("Set a breakpoint here to add credentials if you")
            print("want this test to run.")
            print("")
            
            // To store your credentials in the keychain, uncomment the method call below,
            // and change the parameters to your real API sandbox login info.
            // Then, re-run this test. After it runs, revert your changes.
            //
            // Ideally we would do this on the lldb command line in Xcode, but as of Xcode 7.3
            // that does not work:
            //
            //     ((lldb) p save_sandbox_root_credentials("foo", password: "bar")
            //     error: Execution was interrupted, reason: internal c++ exception breakpoint(-4)..
            //     The process has been returned to the state before expression evaluation.

            // save_sandbox_root_credentials("foo", password: "bar")
        
        } else {
            
            let expectation = expect()

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
                
                expectation.fulfill()
            }
            
            confirm()
        }
    }
    
    
    // FIXME: add test for auth() with .AuthKey credentials
    // FIXME: add test for auth() with .SAM credentials
    
    
    /// Make a bogus request and assert the expected error happens.
    
    func test_issue_password_reset_token() {
        let expectation = expect()
        
        
        Request.issuePasswordResetToken("fragnock@whut.com").run { (result) in
            
            XCTAssert(result.error != nil)
            XCTAssert(result.error?.errorCode == "AUM0004")
            
            let message = result.error?.message ?? ""
            XCTAssert(message.containsString("nvalid email address"))
            
            print("\(result.error)" ?? "")
            print(result.text)
            
            expectation.fulfill()
        }
        
        confirm()
    }
    
    
    /// This function makes it easy for the end user running these tests to store credentials in the Keychain.
    
    func save_sandbox_root_credentials(emailAddress: String, password: String) {
        let creds     = SoracomCredentials(type: .RootAccount, emailAddress: emailAddress, password: password)
        let namespace = storageNamespaceForTestCredentials
        let wrote = creds.writeToSecurePersistentStorage(namespace: namespace)
        print(wrote ? "SUCCESSFULLY WROTE CREDENTIALS. \(namespace)" : "ERROR! COULD NOT WRITE CREDENTIALS.")
    }
    
}
