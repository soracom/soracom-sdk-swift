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
        
        SoracomCredentials.defaultStorageNamespace = self.storageNamespaceForSandboxCredentials
        
        dispatch_once(&oneTimeTestSetupToken) {
            
            // FIXME: This is the first working iteration of this code. Provided you have manually entered a .RootAccount credential
            // for the API Sandbox, it will use that to create an API Key and API Token that is then used to run the tests.
            //
            // However, API Sandbox accounts expire after about a week or so, so this means that the user will have to manually
            // enter credentials if the tests have not run for a week.
            //
            // In the end, this should use the credentials for a real production SAM user, and then automatically create an account
            // in the API Sandbox, if necessary, before doing what it currently does. That way, the user will only have to manually
            // enter credentials one time per machine the tests are run on. (Not doing that today, though.)
            //
            // Update 2016-05-07: Now the demo app can at least be used to create a sandbox user, which will then be used to run the tests.
            // This means you don't really have to do it in the debugger anymore, at least when playing with the demo app. You will still
            // have to do it when running the tests in your own app, though, as storage keys are unique across apps.
            
            print("------------------------------")
            print("--- BaseTestCase will now attempt to set up the testing environment for this test run.")
            print("--- ✅ Set the app-wide default storage namespace to BaseTestCase.storageNamespaceForSandboxCredentials.")
            
            let creds = self.credentialsForTestUse(.RootAccount, caller: "tests that need them")
            
            if (creds == nil) {
                print("--- ⚠️ There are no stored API sandbox credentials. This is OK, but it means")
                print("--- many tests will not run.")
                print("--- ")
                print("--- Note that one easy way to store API sandbox credentials is to run the demo app ")
                print("--- and use the GUI to create a sandbox user. The credentials for that sandbox user ")
                print("--- will be stored securely, and used for the tests that need a sandbox user to run. ")
                print("--- ")
            
            } else {
             
                print("--- ✅ Found stored API sandbox credentials. Will attempt to refresh API key and token... ")

                self.beginAsyncSection()
                
                Request.auth(creds).run { (response) in
                    
                    if let err = response.error {
                     
                        print("--- ⚠️ An error occurred:")
                        print("--- ⚠️ \(err)")
                    
                    } else {
                        
                        var wentOK = false
                        
                        if let authResponse = AuthResponse(response.payload),
                           let operatorId   = authResponse.operatorId,
                           let apiKey       = authResponse.apiKey,
                           let apiToken     = authResponse.token
                        {
                            wentOK = SoracomCredentials(type: .KeyAndToken, operatorID: operatorId, apiKey: apiKey, apiToken: apiToken).writeToSecurePersistentStorage() // no need to set namespace because we set default above
                            print(apiToken)
                        }
                        
                        if (wentOK) {
                            print("--- ✅ Stored API Key and Token successfully. All tests will therefore run. ")

                        } else {
                            print("--- ⚠️ WTF: unexpected happening! 🤔")
                            print(response)
                        }
                    }
                    
                    self.endAsyncSection()
                }
                
                self.waitForAsyncSection()

                print("------------------------------")
            }
            
        }
    }
    

    /// This credentials storage namespace is used when tests need **actual production** credentials. For example, some tests need credentials for a real Soracom SAM user, in order to create an account in the API sandbox. Writing any other credentials to this namespace should be avoided.
    
    let storageNamespaceForProductionCredentials = NSUUID(UUIDString: "454BA030-3DBC-4D09-BFC3-35CE9C7BDFFF")!
    

    /// This credentials storage namespace is used when tests need working API Sandbox credentials. Most tests that make network requests to exercise API functions need these credentials. Writing any other credentials to this namespace should be avoided. **NOTE**: The UUID used for this namespace is intentially the same as the demo app uses, so that the demo app can be used to create a dummy user in the sandbox that will then be used to run the tests which require a sandbox user.

    let storageNamespaceForSandboxCredentials = NSUUID(UUIDString: "DEAE490F-0A00-49CD-B2AF-401215E15122")!
    
    /// /// This credentials storage namespace is used when tests need to read/write credentials as part of their test work. This namespace should be used when the credentials are only needed during the execution of a single test. Various test cases may write to this namespace, so no assumptions should be made about what it contains. 
    
    let storageNamespaceForJunkCredentials = NSUUID(UUIDString: "FE083FA9-79CB-4D61-9E12-9BD609C9743B")!

    
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
        saveAuthKeyCredentialsForTests(authKeyID: authKeyID, authKeySecret: authKeySecret, production: true)
    }
    
    
    func saveSandboxAuthKeyCredentialsForTests(authKeyID authKeyID: String, authKeySecret: String) {
        saveAuthKeyCredentialsForTests(authKeyID: authKeyID, authKeySecret: authKeySecret, production: false)
    }
    
    
    func saveAuthKeyCredentialsForTests(authKeyID authKeyID: String, authKeySecret: String, production: Bool = false) {
        
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
