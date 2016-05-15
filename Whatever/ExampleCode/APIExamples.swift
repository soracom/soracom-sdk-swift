// APIExamples.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

class ExampleCode {
    
    /// Returns the single shared NSOperationQueue instance used to run all requests.
    
    static let sharedInstance = ExampleCode()
    
    let queue = RequestQueue.sharedQueue
    
    
    
    
    func cancelAllOperations(errorObj: Any? = nil) {
        self.queue.cancelAllOperations()
        print("Because there was an error, all further operations in this queue have been canceled.")
        print("The error was: \(errorObj ?? "unknown error")")
    }

    
    /// Create a new user in the API sandbox. This is a multi-step process. Using the operation queue, we can run the different steps sequentially, waiting on each before running the next.
    
    func createSandboxUser(emailAddress: String, password: String, finalOperation: NSOperation? = nil) {
        
        print("🚀 Will try to create a new API Sandbox user...")
        
        let credentialsForSAMUser = Credentials.credentialsForProductionSAMUser
        
        guard !credentialsForSAMUser.blank else {
            print("Sorry, we need credentials (for a real SAM user from the production environment) to proceed. Please enter credentials above, and try again.")
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
        
        var password = password
        if password == "" {
            password = NSUUID().UUIDString + "aBc0157$"
        }
        
        var msg = "This operation will attempt to create a dummy user for testing, in the API sandbox.\n\n"
        msg    += "  Email Address: \(emailAddress)\n"
        msg    += "  Password:      \(password)\n"
        print(msg)
        
        // CREATE OPERATOR
        // First, create the operator. In the API Sandbox, this operation does not need to be authorized
        // with credentials, because it is the equivalent of signing up with a new account.
        
        let createOperatorRequest = Request.createOperator(emailAddress, password: password) { (response) in
            
            print("The createOperator request has returned its response.")
            
            if let error = response.error {
                self.cancelAllOperations(error)
            } else {
                print("No errors occurred, so the next operation in the queue will be run.")
            }
        }
        
        // GET SIGNUP TOKEN
        // This is the one step that requires real SAM user credentials from the production environment.
        
        let dummyUserTokenIdentifier = "createDummyUser.token"
        
        let signupRequest = Request.getSignupToken(email: emailAddress, authKeyId: credentialsForSAMUser.authKeyID, authKey: credentialsForSAMUser.authKeySecret) { (response) in
            
            print("The getSignupToken request has returned its response.")
            
            if let error = response.error {

                self.cancelAllOperations(error)
            
            } else {
                
                if let token = response.payload?[.token] as? String {
                    
                    let tokenCredentials = SoracomCredentials(apiToken: token)
                    tokenCredentials.writeToSecurePersistentStorage(dummyUserTokenIdentifier, replaceDefault: false)
                    
                    print("The token for the dummy user has been saved for use in the next step.")
                    
                } else {
                    self.cancelAllOperations("Hmm, no token was received, which should have caused an error. This is a bug in the SDK itself! 😮")
                }
            }
        }
        
        
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
            
            let credentials    = SoracomCredentials(withStorageIdentifier: dummyUserTokenIdentifier)
            let verifyOperator = Request.verifyOperator(token: credentials.apiToken)
            
            verifyOperator.responseHandler = { (response) in
                
                if let error = response.error {
                    
                    self.cancelAllOperations(error)
                    
                } else {
                    
                    // If we get here, then the multi-operation process of creating a user in the API Sandbox
                    // has completed successfully. So, store the credentials so that we may use this sandbox
                    // user to do various other things.
                    
                    let sandboxCredentials = SoracomCredentials(type: .RootAccount, emailAddress: emailAddress, password: password)
                    Credentials.saveCredentialsForSandboxUser(sandboxCredentials)
                    
                    // And, tell the user:
                    
                    print("No errors occurred. The dummy user in the API Sandbox was created successfully, and the credentials for the dummy user were stored as the default credentials.")
                    print("  Email Address: \(emailAddress)")
                    print("  Password:      \(password)")
                }
            }
            
            return verifyOperator
        }
        
        // AUTHENTICATE
        // Log in as newly-verified sandbox user, and update the API key and token.
        // But since we only persist the credentials for the sandbox user upon successful
        // completion of verifyOperation above, we have to use APIOperation's capability
        // to defer creation of the request (so that we can look up the credentials stored
        // in that previous step):
        
        let authOperation = APIOperation() {
            
            let authRequest = Request.auth(Credentials.credentialsForSandboxUser)
            
            authRequest.responseHandler = { (response) in
                
                if let payload = response.payload,
                    let apiKey  = payload[.apiKey] as? String,
                    let token   = payload[.token] as? String
                {
                    var creds = Credentials.credentialsForSandboxUser
                    creds.apiKey = apiKey
                    creds.apiToken = token
                    creds.writeToSecurePersistentStorage(replaceDefault: true)
                    
                    print("Authenticated successfully as the newly-created sandbox user, and stored the updated API key and token.")
                    
                } else {
                    self.cancelAllOperations("Authentication as the newly-created sandbox user failed.")
                }
            }
            return authRequest
        }
        
        // REGISTER PAYMENT METHOD
        // Register web payment method:
        
        let paymentMethodInfo = PaymentMethodInfoWebPay(cvc: "123", expireMonth: 12, expireYear: 20, name: "SORAO TAMAGAWA", number: "4242424242424242")
          // This fake credit card info comes from the API Sandbox docs.
        
        let registerPaymentMethodRequest = Request.registerWebPayPaymentMethod(paymentMethodInfo)
        registerPaymentMethodRequest.responseHandler = { (response) in
            
            if let error = response.error {
                print("Hmm. An error ocurred after the sandbox user was successfully created, preventing a payment method from being registered.")
                print("\(error)")
                
            } else {
                print("Successfully addded a (fake) payment method to the sandbox user's account.")
            }
        }
        
        queue.addOperation(APIOperation(createOperatorRequest))
        queue.addOperation(APIOperation(signupRequest))
        queue.addOperation(verifyOperation)
        queue.addOperation(authOperation)
        queue.addOperation(APIOperation(registerPaymentMethodRequest))
        
        if let finalOperation = finalOperation {
            queue.addOperation(finalOperation)
        }
    }

}