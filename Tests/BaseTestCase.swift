// BaseTestCase.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

var oneTimeTestSetupToken: dispatch_once_t  = 0

/// A base class that implements some common conveniences/hacks for the project's tests. e.g. making async tests require less boilerplate.

class BaseTestCase: XCTestCase {

    /// We override `setUp()` to:
    ///
    /// - set the default credentials storage namespace to `BaseTestCase.storageNamespaceForSandboxCredentials`. This lets the tests fetch and use a unique set of credentials. Tests that **write** credentials as part of their testing should do a similar thing, so they do not clobber the credentials used by other tests.
    /// 
    /// - run some one-time setup code that tries to log in to the API sandbox using those credentials, to fetch an expiring API Key and API Token, which is needed for most tests that exercise the API.
    
    override func setUp() {
        
        super.setUp()
        
        SoracomCredentials.defaultStorageNamespace = Client.sharedInstance.storageNamespaceForSandboxCredentials
        
        dispatch_once(&oneTimeTestSetupToken) {
            
            print("------------------------------")
            print("--- BaseTestCase will now attempt to set up the testing environment for this test run.")
            print("--- ✅ Set the app-wide default storage namespace to BaseTestCase.storageNamespaceForSandboxCredentials.")

            var shouldCreateNewSandboxUser = false
            let existingSandboxCredentials = Client.sharedInstance.credentialsForSandboxUser
            
            if existingSandboxCredentials.blank {
                
                shouldCreateNewSandboxUser = true
            
            } else {
                
                let authRequest  = Request.auth(existingSandboxCredentials)
                let authResponse = authRequest.wait()
                
                // If we get an error here, it might be AUM0002 "Invalid username/password supplied."
                // This can be expected to happen frequently, because API Sandbox credentials
                // periodically expire (weekly?).
                //
                // Therefore we should try to make a new sandbox user and auth with it here. If THAT
                // fails, then something else is wrong and we can't fix it here.
                
                if authResponse.error?.code == "AUM0002" {
                    shouldCreateNewSandboxUser = true
                }
            }
            
            if shouldCreateNewSandboxUser {
                
                let existingProductionCredentials = Client.sharedInstance.credentialsForProductionSAMUser
                
                if !existingProductionCredentials.blank {
                    
                    if let newSandboxCredentials = Client.sharedInstance.synchronousCreateSandboxUser(existingProductionCredentials) {
                        
                        //SoracomCredentials.sandboxCredentials = newSandboxCredentials
                        Client.sharedInstance.saveCredentials(newSandboxCredentials, user: .APISandboxUser)
                        
                    } else {
                        print("--- ")
                        print("--- ⚠️ Unable to automatically create an API sandbox user. This probably means")
                        print("--- that the stored production SAM user credentials are not valid. This problem")
                        print("--- cannot be fixed automatically. Try using the demo app to save new credentials.")
                    }
                }
            }
            
            // Many tests need a valid API key/token, and those expire, so we should update even if we have credentials:
            
            if let creds = Client.sharedInstance.synchronousUpdateToken(Client.sharedInstance.credentialsForSandboxUser) {
            
                print("--- ")
                print("--- ✅ Sandbox user \(creds.emailAddress) can authenticate, and will be used to run tests.")
                print("--- ")

            } else {
            
                print("--- ")
                print("--- ⚠️ There are no stored API sandbox credentials. This is OK, but it means")
                print("--- many tests will not run.")
                print("--- ")
                print("--- Note that one easy way to store API sandbox credentials is to run the demo app ")
                print("--- and use the GUI to create a sandbox user. The credentials for that sandbox user ")
                print("--- will be stored securely, and used for the tests that need a sandbox user to run. ")
                print("--- ")
            }
            
            print("------------------------------")
        }
    }
    
    
    // MARK: - Asychronous testing conveniences
    // These are intended to make our normal async test pattern slightly more convenient.
    
    private var asyncSectionExpectation: [String: XCTestExpectation] = [:]
    
    
    /// Creates a test expectation, the same as XCTestCase's `expectationWithDescription()` does. The difference is that it stores the expectation, so keeping the expectation object around in a variable in the test case isn't required. Normally, you end the async section (i.e., fulfill the expectation) by calling `self.endAsyncSection()` from within the async block. However, this method does return the expectation, so that you can capture it and fulfill it the normal XCTestCase way, if you for some reason want to avoid capturing self in the async block.
    
    func beginAsyncSection(description: String = #function) -> XCTestExpectation {
        let expectation = expectationWithDescription(description)
        asyncSectionExpectation["\(description)"] = expectation
        return expectation
    }
    
    
    func endAsyncSection(description: String = #function) {
        guard let ex = asyncSectionExpectation["\(description)"] else {
            fatalError("Ooops! Your async tests seem fubared.")
        }
        ex.fulfill()
    }
    
    
    func waitForAsyncSection(description: String = #function, timeout: NSTimeInterval = 60.0) {
        waitForExpectationsWithTimeout(timeout) { error in
            if let error = error {
                print( "waitForExpectationsWithTimeout got error: \(error.localizedDescription)")
            }
        }
    }
    
}
