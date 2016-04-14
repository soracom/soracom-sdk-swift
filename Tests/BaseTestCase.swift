// BaseTestCase.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest


/// A base class that implements some common conveniences/hacks for the project's tests. e.g. making async tests require less boilerplate.

class BaseTestCase: XCTestCase {
    
    
    let storageNamespaceForProductionCredentials = NSUUID(UUIDString: "454BA030-3DBC-4D09-BFC3-35CE9C7BDFFF")!
    
    let storageNamespaceForSandboxCredentials = NSUUID(UUIDString: "C73085D8-FF86-4749-8CA0-2B6B71298FD6")!
    
    
    /// This method looks up the credentials for test use. Many tests require some kind of credentials created in the API sandbox. Rarely, actual production credentials will be required (e.g. to create a new sandbox user for testing). Even for testing credentials, we don't want to store them in plaintext, so they are stored in secure persistent storage, in their own namespace.
    ///
    /// The tests that require credentials will use this method to look them up. If there are no stored credentials, or if they are blank, then this method will return nil, and the tests that need credentials will be skipped.
    ///
    /// The `production` parameter is `false` by default. If `true` that means the production credentials should be returned; currently the only use case there is creating a new API Sandbox user, which does require the .AuthKey credentials for a SAM user from the real production environment.
    
    func credentialsForTestUse(type: SoracomCredentialType, production: Bool = false, caller: StaticString = #function) -> SoracomCredentials? {
        
        let namespace   = production ? storageNamespaceForProductionCredentials : storageNamespaceForSandboxCredentials
        let credentials = SoracomCredentials(withStoredType: type, namespace: namespace)
        
        if credentials.blank {
            print("")
            print("TEST CREDENTIALS FOR API SANDBOX NOT FOUND.")
            print("This means that \(caller) will not execute.")
            print("Set a breakpoint there to add credentials if you")
            print("want this test to run.")
            print("")
            
            return nil
        
        } else {
            
            return credentials
        }
    }
    
    
    // A NOTE ABOUT SAVING CREDENTIALS WITH THE METHODS BELOW:
    //
    // Ideally, we would do this on the lldb command line in Xcode, but as of Xcode 7.3
    // that does not work:
    //
    //     ((lldb) p save_sandbox_root_credentials("foo", password: "bar")
    //     error: Execution was interrupted, reason: internal c++ exception breakpoint(-4)..
    //     The process has been returned to the state before expression evaluation.
    //
    // It did used to work; seems like an Xcode bug. At any rate, the workaround is to uncomment 
    // the method call where it appears in the test case using it, and then change the parameters
    // to your real credentials instead of "foo" and "bar" or whatever.
    //
    // Then, re-run the test. After it runs once, be sure revert your changes immediately and not
    // accidentally commit your credemtials to your revision control history.
    
    /// Make it easy for the end user running these tests to store credentials in the Keychain, from within Xcode. (See note.)
    
    func saveProductionAuthKeyCredentialsForTests(authKeyID authKeyID: String, authKeySecret: String) {
        print("ooooh!!!")
        
        let creds     = SoracomCredentials(type: .AuthKey, authKeyID: authKeyID, authKeySecret: authKeySecret)
        let namespace = storageNamespaceForProductionCredentials
        let wrote     = creds.writeToSecurePersistentStorage(namespace: namespace)
        
        print(wrote ? "SUCCESSFULLY WROTE CREDENTIALS. \(namespace)" : "ERROR! COULD NOT WRITE CREDENTIALS.")

    }
    
    
    /// Make it easy for the end user running these tests to store credentials in the Keychain, from within Xcode. (See note.)
    
    func saveSandboxRootCredentials(emailAddress: String, password: String) {
        
        let creds     = SoracomCredentials(type: .RootAccount, emailAddress: emailAddress, password: password)
        let namespace = storageNamespaceForSandboxCredentials
        let wrote     = creds.writeToSecurePersistentStorage(namespace: namespace)
        
        print(wrote ? "SUCCESSFULLY WROTE CREDENTIALS. \(namespace)" : "ERROR! COULD NOT WRITE CREDENTIALS.")
    }
    
    
    /// Convenience method for async tests.
    
    func expect(description: String = #function) -> XCTestExpectation {
        print("EXPECT: \(description)")
        return expectationWithDescription(#function)
        
    }
    
    
    /// Convenience method for async tests.
    
    func confirm(timeout: NSTimeInterval = 10.0) {
        waitForExpectationsWithTimeout(timeout) { error in
            if let error = error {
                print( error.localizedDescription )
            }
        }
    }

    
// Mason 2016-04-12: FIXME: relocate this code somewhere down the chain. It doesn't need to be in the base class.
    
//    /// Convenience method to get a new dummy IMSI from the API sandbox, before running your actual tests. You still need to set up expectations in your main test method body. Example:
//    ///
//    ///     let expectation = expect()
//    ///
//    ///     withNewIMSI { (imsi) in
//    ///         // do your test here
//    ///     }
//    ///     confirm()
//
//    func withNewIMSI(handler: (imsi: String) -> ()) {
//        Request.createSandboxSubscriber().run { (result) in
//            XCTAssert(result.error == nil)
//            if let imsi = result["imsi"] as? String {
//                handler(imsi: imsi)
//            } else {
//                XCTFail("withNewIMSI() could not get new IMSI")
//            }
//        }
//    }

}
