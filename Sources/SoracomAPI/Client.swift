// Client.swift Created by mason on 2016-06-16. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// The Client is a higher-level object that demonstrates how to use the SDK building blocks like `Request` and `Response` to perform multi-step operations via the Soracom API. It is not necessary to use the Client class, but it may be useful as a starting point for your own applications. (It is the core of the demo apps on both macOS and iOS, s

open class Client {
    
    /// Returns a single shared Client instance.

    public static let sharedInstance = Client()

    
    /// The queue that the Client will use for scheduling API operations. Uses the global shared RequestQueue by default, but you can set this if desired.
    
    var queue = RequestQueue.sharedQueue
    
    
    /// This type allows you to define your own logging implementation to replace the default (which just does print() and ignores text attributes).
    
    public typealias Logger = ((_ str: String, _ attrs: TextStyle) -> ())
    
    
    /// The logging implementation that will be used. If nil, the default implementation will be used (equivalent to `print()`).
    
    var logger: Logger?  = nil

    
    /// Logs `str` using the `logger` logging implementation if set, otherwise using the default implementation (equivalent to `print()`).
    
    func log(_ str: String, attrs: TextStyle = .normal) {
        
        guard let logger = logger else {
            print(str)
            return
        }
        logger(str, attrs)
    }
    
    
    /// Global status message used by iOS demo app.
    open var sandboxUserAuthenticationStatus = "😑 Idle. Tap Start to begin."
    
    
    /// Global help message used by iOS demo app.
    
    open var helpMessage = ""

    
    
    /// Cancel all queued operations and log a message to that effect.
    
    func cancelAllOperations(_ errorObj: Any? = nil) {
        self.queue.cancelAllOperations()
        log("Because there was an error, all queued operations have been canceled.")
        log("The error was: \(errorObj ?? "unknown error")")
    }
    

    
    
    // MARK: - Authentication
    
    
    // FIXME: there are too many similar-but-different authentications methods, clean this up:
    // deferredAuthOperation(), synchronousUpdateToken(), authenticateAsSandboxUser(), authenticateSandboxUserAndUpdateStoredCredentials() ... this is for historical reasons from all the code that was pulled into this class.

    /// Try to authenticate as sandbox user, and post notification with the result.
    
    /// Create a 'deferred' request operation to authenticate, using the sandbox user root credentials. The
    /// reason this method exists is that we sometimes have to do some work, wait for the results of that work
    /// to be returned by the server, save updated credentials, and then log in using those credentials.
    
    func deferredAuthOperation() -> APIOperation {
        
        let authOperation = APIOperation() {
            
            let credentials   = self.credentialsForSandboxUser
            let reAuthRequest = Request.auth(credentials)
            
            reAuthRequest.responseHandler = { (response) in
                
                if let payload = response.payload,
                    let apiKey  = payload[.apiKey] as? String,
                    let token   = payload[.token] as? String
                {
                    var updatedCredentials    = self.credentialsForUser(.APISandboxUser)
                    updatedCredentials.apiKey = apiKey
                    updatedCredentials.token  = token
                    self.saveCredentials(updatedCredentials, user: .APISandboxUser)
                    
                    self.log("Authenticated successfully as the newly-created sandbox user, and stored the updated API key and token.")
                    
                } else {
                    self.log("Authentication as the newly-created sandbox user failed.")
                }
            }
            return reAuthRequest
        }
        
        return authOperation
    }
    
    
    /// Attempts to authenticate using `credentials`. Upon success, this returns a copy or `credentials` with the updated API key and token returned by the server.
    
    func synchronousUpdateToken(_ credentials: SoracomCredentials?) -> SoracomCredentials? {
        
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
        
        var newCredentials    = credentials
        newCredentials.apiKey = apiKey
        newCredentials.token  = newToken
        
        return newCredentials
    }

    
    open func authenticateAsSandboxUser(_ recreateOnFailure: Bool = false) {
        
        var credentials = credentialsForSandboxUser
        let nc = NotificationCenter.default
        
        guard !credentials.blank else {
            sandboxUserAuthenticationStatus = "⚠️ There is no API Sandbox user. To create one, enter your credentials in Settings."
            nc.post(name: Notifications.SandboxUserAuthenticationDidUpdate, object: nil)
            
            if recreateOnFailure {
                self.createSandboxUser()
            }
            
            return
        }
        
        let authReq = Request.auth(credentials)
        
        authReq.run { (response) in
            
            if let payload = response.payload,
               let apiKey = payload[.apiKey] as? String,
               let token  = payload[.token] as? String
            {
                credentials.apiKey = apiKey
                credentials.token  = token
                _ = credentials.save()
                
                self.sandboxUserAuthenticationStatus = "🆗 Authenticated as: \(credentials.emailAddress)"
                self.helpMessage = ""
                
            } else {
                
                let message = response.error?.message ?? "generic error"
                
                self.sandboxUserAuthenticationStatus = "⚠️ Failed: \(message)"
                
                self.helpMessage = "(Valid SAM user credentials from the production environment are required.)"

                if recreateOnFailure {
                    self.createSandboxUser()
                }
            }
            
            nc.post(name: Notifications.SandboxUserAuthenticationDidUpdate, object: nil)
        }
    }
    
    
    /// This method looks up the stored sandbox user credentials, tries to authenticate with them, and on success updates the stored credentials. This assumes that SoracomCredentials.sandboxCredentials is used to read/write the sandbox user's credentials (which isn't necessarily true, but happens to be true for the SDK demo apps).
    
    func authenticateSandboxUserAndUpdateStoredCredentials() {
        
        // FIXME: this could be made more generic...
        
        log("🚀 Will try to authenticate...")
        
        sandboxUserAuthenticationStatus = "Trying to authenticate as API Sandbox user..."
        
        let credentials = self.credentialsForSandboxUser
        
        guard !credentials.blank else {
            log("No credentials were found. Try creating the API Sandbox user first.")
            return
        }
        
        let authReq = Request.auth(credentials) { (response) in
            
            if response.error != nil {
            
                self.log("Authentication failed. Note that API Sandbox users do expire periodically; you may need to create a new sandbox user in that case.")
            
            } else {
                
                if let payload = response.payload, let token = payload[.token] as? String {

                    self.log("Authenticated successfully. 😁")

                    var updatedCredentials   = self.credentialsForSandboxUser
                    updatedCredentials.token = token
                    self.saveCredentials(updatedCredentials, user: .APISandboxUser)
                }
            }
        }
        
        let authOp = APIOperation(authReq)
        queue.addOperation(authOp)
    }


    
    // MARK: - Create dummy SIM(s) (which exist in the API Sandbox)
    
    /// Create a single dummy SIM in the sandbox environment.
    
    func createSandboxSIM() {
        log("🚀 Will try to create a SIM (aka 'subscriber') in the API Sandbox, and register it...")
        
        log("This operation will attempt to create a subscriber object (SIM) in the API sandbox. You can then use the data pertaining to that subscriber for testing, as if they were real SIMs that you had purchased. (The first step would be to register it.)")
        
        let req = Request.createSandboxSubscriber() { (response) in
            
            if let payload = response.payload, let imsi = payload[.imsi] as? String, let secret = payload[.registrationSecret] as? String{
                
                let registerRequest = Request.registerSubscriber(imsi, registrationSecret: secret)
                self.queue.addOperation(APIOperation(registerRequest))
                
            } else {
                self.log("Uh-oh: couldn't create SIM, but handling that error is beyond the scope of this demo app.")
            }
            
        }
        let op  = APIOperation(req)
        queue.addOperation(op)
        // The above could insted be done like this: req.run()
    }
    
    
    /// List all sandbox SIMs
    func listSandboxSIMs() {
        log("🚀 Will try to list all SIMs (aka 'subscribers') that are registered in the API Sandbox...")
        
        let req = Request.listSubscribers()
        let op  = APIOperation(req)
        queue.addOperation(op)
    }
    
    
    // MARK: - Multi-step examples
    
    /// Queues a series of asynchronous operations to create a new user in the API sandbox. This is a multi-step process. Using the operation queue, we can run the different steps sequentially, waiting on each before running the next. Returns nothing, because the operations queued by this function will be executed at a later time.
    
    func createSandboxUser(_ productionCredentials: SoracomCredentials? = nil, email: String? = nil, password: String? = nil) {
        
        // FIXME: make read/write credentials overridable somehow
        // FIXME: then, add a unit test for this, which tests this method without affecting stored credentials used elsewhere
        
        log("🚀 Will try to create a new API Sandbox user...")

        let productionCredentials = productionCredentials ?? self.credentialsForProductionSAMUser

        guard !productionCredentials.blank else {
            log("Sorry, we need credentials (for a real SAM user from the production environment) to proceed. Please enter credentials above, and try again.")
            return
        }
        
        guard queue.operationCount == 0 else {
            print("Sorry, the queue has existing operations pending (see below). For clarity, this demo app only supports a single queue, and only accepts new operations when idle. Feel free to fork it and go wild, though!")
            print("Here is what is currently in the queue: ")
            
            for op in queue.operations {
                print("     \(op)")
            }
            return
        }

        func makeValid(_ orig: String?, _ sub: String) -> String {
            guard let orig = orig else {
                return sub
            }
            return orig == "" ? sub : orig
        }
        
        let uuid     = UUID().uuidString
        let email    = makeValid(email, "\(uuid)@example.com")
        let password = makeValid(password, "\(uuid)aBc0157$")
    
        log("This operation will attempt to create a sandbox user for testing, in the API sandbox.")
        log("  Email Address: \(email)")
        log("  Password:      \(password)")

        
        // CREATE OPERATOR
        // First, create the operator. In the API Sandbox, this operation does not need to be authorized
        // with credentials, because it is the equivalent of signing up with a new account.

        let createOperatorRequest = Request.createOperator(email, password: password) { (response) in
            
            self.log("The createOperator request has returned its response.")
            
            if let error = response.error {
                self.cancelAllOperations(error)
            } else {
                print("No errors occurred, so the next operation in the queue will be run.")
            }
        }
        
        let createOperatorOperation = APIOperation(createOperatorRequest)
        queue.addOperation(createOperatorOperation)
        
        
        // GET SIGNUP TOKEN
        // This is the one step that requires real SAM user credentials from the production environment.
        
        let sandboxUserTokenIdentifier = "createSandboxUser.token"

        let signupRequest = Request.getSignupToken(email: email, authKeyId: productionCredentials.authKeyID, authKey: productionCredentials.authKeySecret) { (response) in
            
            self.log("The getSignupToken request has returned its response.")
            
            if let error = response.error {
                
                self.cancelAllOperations(error)
                
            } else {
                
                if let token = response.payload?[.token] as? String {
                    
                    let tokenCredentials = SoracomCredentials(token: token)
                    _ = tokenCredentials.save(sandboxUserTokenIdentifier)
                    
                    self.log("The token for the sandbox user has been saved for use in the next step.")
                    self.log("No errors occurred, so the next operation in the queue will be run.")
                    
                } else {
                    self.cancelAllOperations("Hmm, no token was received, which should have caused an error. This is a bug in the SDK itself! 😮")
                }
            }
        }
        
        let signupOperation = APIOperation(signupRequest)
        queue.addOperation(signupOperation)
        

        // VERIFY OPERATOR
        // This next step illustrates initializing an APIOperation with a RequestBuilder instead of a Request,
        // which allows you to defer the creation of the request until the time the operation is executed.
        //
        // We use this form because at this point we are just building the queue; we haven't run any of these
        // operations yet, and therefore don't yet have the API Token we want to verify. (We won't have it
        // until the `signupOperation` above executes.)
        //
        // So, we initialize `verifyOperation` using the `RequestBuilder` below. By the time `verifyOperation`
        // executes, `signupOperation` will have executed, and the token will have been stored, so we can look
        // it up and use it to create the Request instance that `verifyOperation` will run to verify the token.

        let verifyOperation = APIOperation() {
            
            let credentials    = SoracomCredentials(withStorageIdentifier: sandboxUserTokenIdentifier)
            
            let verifyOperator = Request.verifyOperator(token: credentials.token) { (response) in
                
                if let error = response.error {
                    
                    self.cancelAllOperations(error)
                    
                } else {
                    
                    // If we get here, then the multi-operation process of creating a user in the API Sandbox
                    // has completed successfully. So, store the credentials so that we may use this sandbox
                    // user to do various other things:
                    
                    let sandboxCredentials = SoracomCredentials(type: .RootAccount, emailAddress: email, password: password)
                    self.saveCredentials(sandboxCredentials, user: .APISandboxUser)
                    
                    // And, tell the user:
                    
                    self.log("No errors occurred. The sandbox user was created in the API Sandbox successfully, and the sandbox user's credentials were stored under the special namespace \(self.storageNamespaceForSandboxCredentials.uuidString):")
                    self.log("  Email Address: \(email)")
                    self.log("  Password:      \(password)")
                }
            }
            
            return verifyOperator
        }
        queue.addOperation(verifyOperation)
        
        
        // AUTHENTICATE
        // Next, we log in as newly-verified sandbox user, and update the API key and token.
        // But since we only persist the credentials for the sandbox user upon successful
        // completion of verifyOperation above, and those credentials are used to initialize
        // this next Request object, we have to use APIOperation's capability
        // to defer creation of the request (so that we can look up the credentials stored
        // in that previous step):
        
        queue.addOperation(deferredAuthOperation())
        
        
        // REGISTER PAYMENT METHOD
        // Register web payment method:
        
        let paymentMethodInfo = CreditCard(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
        // This fake credit card info comes from the API Sandbox docs.
        
        let registerPaymentMethodRequest = Request.registerWebPayPaymentMethod(creditCard: paymentMethodInfo)
        registerPaymentMethodRequest.responseHandler = { (response) in
            
            if let error = response.error {
                self.log("Hmm. An error ocurred after the sandbox user was successfully created, preventing a payment method from being registered.")
                self.log("\(error)")
                
            } else {
                self.log("Successfully added a (fake) payment method to the sandbox user's account.")
            }
        }
        
        let registerPaymentMethodOperation = APIOperation(registerPaymentMethodRequest)
        queue.addOperation(registerPaymentMethodOperation)
        
        // Finally, after adding payment method, we have to refresh our token one more time:
        queue.addOperation(deferredAuthOperation())
    }

    
    /// Create a user in the API Sandbox, returning the new user's credentials if successful, otherwise nil.
    
    func synchronousCreateSandboxUser(_ productionCredentials: SoracomCredentials, email: String? = nil, password: String? = nil) -> SoracomCredentials? {
        
        print("CREATE SANDBOX USER")
        
        let uuid     = UUID().uuidString
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
        
        newUserCredentials.apiKey = apiKey
        newUserCredentials.token  = newToken
        
        // Register a (fake) credit card:
        
        let paymentMethodInfo = CreditCard(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
        // This fake credit card info comes from the API Sandbox docs.
        
        let registerPaymentMethodRequest  = Request.registerWebPayPaymentMethod(creditCard: paymentMethodInfo)
        
        registerPaymentMethodRequest.credentials = newUserCredentials
        // This step is necessary because we have not yet saved the credentials anywhere, so the request would otherwise use previously-cached credentials (and therefore, fail).
        
        let registerPaymentMethodResponse = registerPaymentMethodRequest.wait()
        
        guard registerPaymentMethodResponse.error == nil else {
            print("failed to create a new sandbox user: could not add payment method: \(registerPaymentMethodResponse)")
            return nil
        }
        
        // Authenticate as new sandbox user again, after adding payment method, to update token:
        
        guard let updatedCredentials = synchronousUpdateToken(newUserCredentials) else {
            print("failed to create a new sandbox user: could not re-authenticate as sandbox user: \(authResponse)")
            return nil
        }
        
        return updatedCredentials
    }
    
    
    // MARK: - Testing & Debugging Helpers
    
    
    public func doInitialHousekeeping() {
        
        log("Credentials for API Sandbox user: \(self.credentialsForSandboxUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        log("Credentials for production SAM user: \(self.credentialsForProductionSAMUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        
        // To make all the automated tests run, you need to enter real production credentials for a SAM user.
        // But is very cumbersome to enter text into the iOS Simulator. One alternative is to set a breakpoint
        // and do it from the lldb debugger console in Xcode, as described below:
        
        var authKeyId      = ""
        var authKeySecret  = ""
        
        authKeyId     += authKeySecret
        authKeySecret += authKeyId
        // this bit of jiggery-pokery is to prevent the compiler from optimizing out our if check below
        
        // Set a breakpoint on this line, then do this in the debugger:
        //
        //        (lldb) p authKeyId = "keyId-xXxXx_YOUR_REAL_KEY_ID_HERE_xXXxX"
        //        (lldb) p authKeySecret = "secret-xXxXx_YOUR_REAL_KEY_SECRET_HERE_xXXxX"
        //
        // ...then, continue execution to allow the code below to store your credentials securely
        // in the iOS keychain. Note: you may have to navigate into the Settings screen and back out
        // one time for the new credentials to be noticed.
        
        if (authKeyId.count > 2 && authKeySecret.count > 2) {
            
            let productionCredentials = SoracomCredentials(type: .AuthKey, authKeyID: authKeyId, authKeySecret: authKeySecret)
            Client.sharedInstance.saveCredentials(productionCredentials, user: .ProductionSAMUser)
        }
        
        // Uncommenting the below can also be useful for debugging. It will cause every request and response
        // to be printed.
        //
        //        Request.beforeRun { (request) in
        //            print(request)
        //        }
        //
        //        Request.afterRun { (response) in
        //            print(response)
        //        }
        //
        //        RequestResponseFormatter.shouldRedact = false
        

    }
    
    // MARK: - Conventions for reading/writing credentials
    
    
    /// This credentials storage namespace is used when **actual production** credentials are needed. Note that this is sometimes true of the automated tests; some tests need credentials for a real Soracom SAM user, in order to create an account in the API sandbox. (Note: this namespace is just defined for convenience, so that the demo apps and automated tests can use the same namespaces.)
    
    public let storageNamespaceForProductionCredentials = UUID(uuidString: "454BA030-3DBC-4D09-BFC3-35CE9C7BDFFF")!
    
    
    /// This credentials storage namespace is intended for API Sandbox credentials. Most tests that make network requests to exercise API functions need these credentials. Writing any other credentials to this namespace should be avoided.
    
    public let storageNamespaceForSandboxCredentials = UUID(uuidString: "DEAE490F-0A00-49CD-B2AF-401215E15122")!
    
    
    /// This credentials storage namespace is used when tests need to read/write credentials as part of their test work. This namespace should be used when the credentials are only needed during the execution of a single test. Various test cases may write to this namespace, so no assumptions should be made about what it contains.
    
    public let storageNamespaceForJunkCredentials = UUID(uuidString: "FE083FA9-79CB-4D61-9E12-9BD609C9743B")!
    
    
    /// Returns the credentials for the API Sandbox user. (May be blank.)
    
    public var credentialsForSandboxUser: SoracomCredentials {
        
        return self.credentialsForUser(.APISandboxUser)
    }
    
    
    /// Returns the credentials for the production SAM user. (May be blank.)
    
    public var credentialsForProductionSAMUser: SoracomCredentials {
        
        return self.credentialsForUser(.ProductionSAMUser)
    }
    
    
    /// Returns the stored credentials corresponding to `user` (or a blank SoracomCredentials struct if none are stored).
    
    public func credentialsForUser(_ user: User) -> SoracomCredentials {
        
        return SoracomCredentials(withStorageIdentifier: nil, namespace: storageNamespaceForUser(user))
    }
    
    
    /// Store the credentials in secure persistent storage (i.e., system keychain), as the default credentials in the namespace appropriate for `user`.
    
    public func saveCredentials(_ credentials: SoracomCredentials, user: User) {
        _ = credentials.save(namespace: storageNamespaceForUser(user))
          // the SDK demo apps are simple 
    }
    
    
//    public func deleteCredentialsForUser(user: User) {
//        
//    }
    
    
    /// Returns the storage namespace for the given user. (This implementation is for the SDK demo apps, which have simple requirements; all the possible user types are known in advance.)
    
    public func storageNamespaceForUser(_ user: User) -> UUID {
        
        switch user {
        
        case .ProductionSAMUser:
            return storageNamespaceForProductionCredentials
        
        case .APISandboxUser:
            return storageNamespaceForSandboxCredentials
        }
    }
    

}



/// This enum defines values (with raw values that are strings) that identify the types of users for which the SDK demo apps (and the automated tests) need to read/write credentials.

public enum User: String {
    case ProductionSAMUser
    case APISandboxUser
}
