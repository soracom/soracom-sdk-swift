// AppDelegate+APIExamples.swift Created by mason on 2016-04-23. Copyright © 2016 masonmark.com. All rights reserved.


import Foundation


/// This extension is where all the actual API requests code lives.

extension AppDelegate {
    
    
    // MARK: Authentication
    
    func authWithCredentials(credentials: SoracomCredentials, userType: UserType? = nil) {

        log("🚀 Will try to authenticate as the API Sandbox user...")

        guard !credentials.blank else {
            log("No credentials were found. Try creating the API Sandbox user first.")
            return
        }
        
        let authReq = Request.auth(credentials) { (response) in
            
            if response.error != nil {
                self.log("Authentication failed. Note that API Sandbox users do expire periodically; you can create a new sandbox user in that case.")
            } else {
                self.log("Authenticated successfully. 😁")
                
                if let userType = userType, payload = response.payload, token = payload[.token] as? String {
                    switch userType {
                    case .Sandbox:
                        var creds = SoracomCredentials.sandboxCredentials
                        creds.apiToken = token
                        SoracomCredentials.sandboxCredentials = creds
                    default:
                        break
                    }
                }
            }
        }

        
        let authOp = APIOperation(authReq)
        queue.addOperation(authOp)
        
        // Before we had an operation queue, it looked like this:
        //
        //        authReq.run { (response) in
        //
        //            if response.error != nil {
        //                self.log("Authentication failed. Note that API Sandbox users do expire periodically; you can create a new sandbox user in that case.")
        //            } else {
        //                self.log("Authenticated successfully. 😁")
        //            }
        //        }
    }
    
    
    // MARK: - Create dummy SIM(s) (which exist in the API Sandbox)
    
    /// Create a single dummy SIM in the sandbox environment.
    
    func createSandboxSIM() {
        log("🚀 Will try to create a SIM (aka 'subscriber') in the API Sandbox, and register it...")

        log("This operation will attempt to create a subscriber object (SIM) in the API sandbox. You can then use the data pertaining to that subscriber for testing, as if they were real SIMs that you had purchased. (The first step would be to register it.)")
        
        let req = Request.createSandboxSubscriber() { (response) in
         
            if let payload = response.payload, imsi = payload[.imsi] as? String, secret = payload[.registrationSecret] as? String{
                
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
        log("🚀 Will try to list all SIMs (aka 'subscribers') that are regsitered in the API Sandbox...")
        
        let req = Request.listSubscribers()
        let op  = APIOperation(req)
        queue.addOperation(op)
    }
    
    
    // MARK: - Multi-step examples
    
    /// Create a new user in the API sandbox. This is a multi-step process. Using the operation queue, we can run the different steps sequentially, waiting on each before running the next.
    
    func createSandboxUser() {
        
        log("🚀 Will try to create a new API Sandbox user...")
        
        let productionCredentials = SoracomCredentials.productionCredentials

        guard !productionCredentials.blank else {
            log("Sorry, we need credentials (for a real SAM user from the production environment) to proceed. Please enter credentials above, and try again.")
            return
        }
        
        guard queue.operationCount == 0 else {
            log("Sorry, the queue has existing operations pending (see below). For clarity, this demo app only supports a single queue, and only accepts new operations when idle. Feel free to fork it and go wild, though!")
            log("Here is what is currently in the queue: ")
            
            for op in queue.operations {
                log("     \(op)")
            }
            return
        }
        
        let emailAddress = sandboxUserEmailField.stringValue
        var password     = sandboxUserPasswordField.stringValue
        
        if password == "" {
            password = NSUUID().UUIDString + "aBc0157$"
        }
        
        var msg = "This operation will attempt to create a sandbox user for testing, in the API sandbox.\n\n"
        msg    += "  Email Address: \(emailAddress)\n"
        msg    += "  Password:      \(password)\n"
        log(msg)
        
        // First, create the operator. In the API Sandbox, this operation does not need to be authorized
        // with credentials, because it is the equivalent of signing up with a new account.
        
        let sandboxUserTokenIdentifier = "createSandboxUser.token"
        
        let createOperatorRequest = Request.createOperator(emailAddress, password: password) { (response) in
            
            self.log("The createOperator request has returned its response.")
            
            if response.error != nil {
                self.queue.cancelAllOperations()
                self.log("Because there was an error, all further operations in this queue have been canceled.")
            } else {
                self.log("No errors occurred, so the next operation in the queue will be run.")
            }
        }
        
        let createOperatorOperation = APIOperation(createOperatorRequest)
        queue.addOperation(createOperatorOperation)
        
        
        let signupRequest = Request.getSignupToken(email: emailAddress, authKeyId: productionCredentials.authKeyID, authKey: productionCredentials.authKeySecret) { (response) in
            
            self.log("The getSignupToken request has returned its response.")
            
            if response.error != nil {
                
                self.queue.cancelAllOperations()
                self.log("Because there was an error, all further operations in this queue have been canceled.")
                
            } else {
                
                if let token = response.payload?[.token] as? String {
                    
                    let tokenCredentials = SoracomCredentials(apiToken: token)
                    tokenCredentials.writeToSecurePersistentStorage(sandboxUserTokenIdentifier, replaceDefault: false)
                    
                    self.log("The token for the sandbox user has been saved for use in the next step.")
                    self.log("No errors occurred, so the next operation in the queue will be run.")
                    
                } else {
                    self.log("Hmm, no token was received, which should have caused an error. This is a bug in the SDK itself! 😮")
                }
            }
        }
        
        let signupOperation = APIOperation(signupRequest)
        queue.addOperation(signupOperation)
        
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
            
            let verifyOperator = Request.verifyOperator(token: credentials.apiToken) { (response) in
                
                if response.error != nil {
                    self.queue.cancelAllOperations()
                    self.log("Because there was an error, all further operations in this queue have been canceled.")
                } else {
                    
                    // If we get here, then the multi-operation process of creating a user in the API Sandbox
                    // has completed successfully. So, store the credentials so that we may use this sandbox
                    // user to do various other things:
                    
                    SoracomCredentials.sandboxCredentials = SoracomCredentials(type: .RootAccount, emailAddress: emailAddress, password: password)
                    
                    // And, tell the user:
                    
                    self.log("No errors occurred. The sandbox user was created in the API Sandbox successfully, and the sandbox user's credentials were stored under the special namespace \(SoracomCredentials.storageNamespaceForSandboxCredentials.UUIDString):")
                    self.log("  Email Address: \(emailAddress)")
                    self.log("  Password:      \(password)")
                }
            }
            
            return verifyOperator
        }
        queue.addOperation(verifyOperation)

        // Next, we in as newly-verified sandbox user, and update the API key and token.
        // But since we only persist the credentials for the sandbox user upon successful 
        // completion of verifyOperation above, and those credentials are used to initialize
        // this next Request object, we have to use APIOperation's capability
        // to defer creation of the request (so that we can look up the credentials stored
        // in that previous step):
        
        queue.addOperation(deferredAuthOperation())

        
        // Register web payment method:
        
        let paymentMethodInfo = PaymentMethodInfoWebPay(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
          // This fake credit card info comes from the API Sandbox docs.

        let registerPaymentMethodRequest = Request.registerWebPayPaymentMethod(paymentMethodInfo)
        registerPaymentMethodRequest.responseHandler = { (response) in
            
            if let error = response.error {
                self.log("Hmm. An error ocurred after the sandbox user was successfully created, preventing a payment method from being registered.")
                self.log("\(error)")
            
            } else {
                self.log("Successfully addded a (fake) payment method to the sandbox user's account.")
            }
        }
        
        let registerPaymentMethodOperation = APIOperation(registerPaymentMethodRequest)
        queue.addOperation(registerPaymentMethodOperation)
        
        // Finally, after adding payment method, we have to refresh our token one more time: 
        queue.addOperation(deferredAuthOperation())
    }
    
    
    /// Create a 'deferred' request operation to authenticate, using the sandbox user root credentials. The
    /// reason this method exists is that we sometimes have to do some work, wait for the results of that work
    /// to be returned by the server, save updated credentials, and then log in using those credentials.
    
    func deferredAuthOperation() -> APIOperation {
        
        let authOperation = APIOperation() {
            
            let reAuthRequest = Request.auth(SoracomCredentials.sandboxCredentials)
            
            reAuthRequest.responseHandler = { (response) in
                
                if let payload = response.payload,
                    let apiKey  = payload[.apiKey] as? String,
                    let token   = payload[.token] as? String
                {
                    var creds = SoracomCredentials.sandboxCredentials
                    creds.apiKey = apiKey
                    creds.apiToken = token
                    SoracomCredentials.sandboxCredentials = creds
                    
                    self.log("Authenticated successfully as the newly-created sandbox user, and stored the updated API key and token.")
                    
                } else {
                    self.log("Authentication as the newly-created sandbox user failed.")
                }
            }
            return reAuthRequest
        }
        
        return authOperation
    }

}