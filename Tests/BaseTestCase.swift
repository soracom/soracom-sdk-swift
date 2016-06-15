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
        
        SoracomCredentials.defaultStorageNamespace = SoracomCredentials.storageNamespaceForSandboxCredentials
        
        dispatch_once(&oneTimeTestSetupToken) {
            
            print("------------------------------")
            print("--- BaseTestCase will now attempt to set up the testing environment for this test run.")
            print("--- ✅ Set the app-wide default storage namespace to BaseTestCase.storageNamespaceForSandboxCredentials.")

            var shouldCreateNewSandboxUser = false
            let existingSandboxCredentials = SoracomCredentials.sandboxCredentials
            
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
                
                let existingProductionCredentials = SoracomCredentials.productionCredentials
                
                if !existingProductionCredentials.blank {
                    
                    if let newSandboxCredentials = self.createSandboxUser(existingProductionCredentials) {
                        SoracomCredentials.sandboxCredentials = newSandboxCredentials
                    } else {
                        print("--- ")
                        print("--- ⚠️ Unable to automatically create an API sandbox user. This probably means")
                        print("--- that the stored production SAM user credentials are not valid. This problem")
                        print("--- cannot be fixed automatically. Try using the demo app to save new credentials.")
                    }
                }
            }
            
            // Many tests need a valid API key/token, and those expire, so we should update even if we have credentials:
            
            if let creds = self.updateToken(SoracomCredentials.sandboxCredentials) {
            
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
    
    
    // MARK: - Multi-step API operations
    
    /// Create a user in the API Sandbox, returning the new user's credentials if successful, otherwise nil.
    
    func createSandboxUser(productionCredentials: SoracomCredentials, email: String? = nil, password: String? = nil) -> SoracomCredentials? {
        
        print("CREATE SANDBOX USER")
        
        let uuid     = NSUUID().UUIDString
        let email    = email    ?? "\(uuid)@example.com"
        let password = password ?? "\(uuid)aBc0157$"
        
        var msg = "This operation will attempt to create a sandbox user for testing, in the API sandbox.\n\n"
        msg    += "  Email Address: \(email)\n"
        msg    += "  Password:      \(password)\n"
        print(msg)
        
        // Create operator:
        
        let createOperatorResponse = Request.createOperator(email, password: password).wait()
        
        guard createOperatorResponse.error == nil else {
            print("failed to create a new sandbox user: could not create operator: \(createOperatorResponse)")
            return nil
        }
        
        // Get signup token (this is the step that needs the production credentials):
        
        let signupRequest = Request.getSignupToken(email: email, authKeyId: productionCredentials.authKeyID, authKey: productionCredentials.authKeySecret)
        
        let signupResponse = signupRequest.wait()
        
        guard signupResponse.error == nil else {
            print("failed to create a new sandbox user: could not get signup token: \(signupResponse)")
            return nil
        }
        
        guard let token = signupResponse.payload?[.token] as? String else {
            print("failed to create a new sandbox user: response did not contain signup token: \(signupResponse)")
            return nil
        }
        
        // Verify the token:
        
        let verifyOperatorRequest  = Request.verifyOperator(token: token)
        let verifyOperatorResponse = verifyOperatorRequest.wait()
        
        guard verifyOperatorResponse.error == nil else {
            print("failed to create a new sandbox user: could not verify signup token: \(verifyOperatorResponse)")
            return nil
        }
        
        // Authenticate as new sandbox user:
        // (if we get here, we should have working .RootAccount credentials for the new API Sandbox user)
        
        var newUserCredentials = SoracomCredentials(type: .RootAccount, emailAddress: email, password: password)
        
        let authRequest  = Request.auth(newUserCredentials)
        let authResponse = authRequest.wait()
        
        guard let payload = authResponse.payload, let apiKey = payload[.apiKey] as? String, let newToken = payload[.token] as? String else
        {
            print("failed to create a new sandbox user: could not authenticate as sandbox user: \(authResponse)")
            return nil
        }
        
        newUserCredentials.apiKey   = apiKey
        newUserCredentials.apiToken = newToken
        
        // Register a (fake) credit card:
        
        let paymentMethodInfo = PaymentMethodInfoWebPay(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
        // This fake credit card info comes from the API Sandbox docs.
        
        let registerPaymentMethodRequest  = Request.registerWebPayPaymentMethod(paymentMethodInfo)
        
        registerPaymentMethodRequest.credentials = newUserCredentials
          // This step is necessary because we have not yet saved the credentials anywhere, so the request would otherwise use previously-cached credentials (and therefore, fail).
        
        let registerPaymentMethodResponse = registerPaymentMethodRequest.wait()
        
        guard registerPaymentMethodResponse.error == nil else {
            print("failed to create a new sandbox user: could not add payment method: \(registerPaymentMethodResponse)")
            return nil
        }
        
        // Authenticate as new sandbox user again, after adding payment method, to update token:
        
        guard let updatedCredentials = updateToken(newUserCredentials) else {
            print("failed to create a new sandbox user: could not re-authenticate as sandbox user: \(authResponse)")
            return nil
        }
        
        return updatedCredentials
    }
    
    
    /// Attempts to authenticate using `credentials`. Upon success, this returns a copy or `credentials` with the updated API key and token returned by the server.
    
    func updateToken(credentials: SoracomCredentials?) -> SoracomCredentials? {
        
        guard let credentials = credentials else {
            return nil
        }
        
        let authRequest  = Request.auth(credentials)
        let authResponse = authRequest.wait()
        
        guard let payload = authResponse.payload, let apiKey = payload[.apiKey] as? String, let newToken = payload[.token] as? String else
        {
            print("failed to update token: authentication failed: \(authResponse)")
            return nil
        }
        
        var newCredentials      = credentials
        newCredentials.apiKey   = apiKey
        newCredentials.apiToken = newToken
        
        return credentials
    }
    
}
