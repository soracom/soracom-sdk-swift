// CLIDemo.swift Created by mason on 2018/02/10. 

import Foundation
import SoracomAPI

open class CLIDemo {
    
    /**
     Runs the demo tool, which will interactively show the user a few features of this SDK.
     */
    open func run() {
        
        showWelcomeMessage()
        
        updateSandboxUserCredentials()
          // This will look up the saved credentials if they exist, otherwise it will prompt for real credentials and use those to create a user in the API Sandbox environment. Then it will authenticate using the credentials, and store the API token received for use with subsequent API calls.
        
        showMainMenu()
          // Most of the actions available from the main menu do their work, and then cause the main menu to be displayed again, until the user quits.
    }
    
    
    // MARK: - User actions that call the API
    
    /**
      When this action is initiated by the user, the demo program registers a payment method (credit card) in the API Sandbox environment. (This is not a real credit card. It is a dummy card, that just allows the sandbox user to perform various operations in the sandbox which require a payment method to be registered. This also re-authenticates upon success, and saves the resulting API token in the stored sandbox user credentials.
     */
    open func registerPaymentMethod() {
        
        let paymentMethodInfo = PaymentMethodInfoWebPay(cvc: "123", expireMonth: 12, expireYear: 2020, name: "SORAO TAMAGAWA", number: "4242424242424242")
          // This fake credit card info comes from the API Sandbox docs.
        
        let registerResponse     = Request.registerWebPayPaymentMethod(paymentMethodInfo).wait()
        let authenticateResponse = Request.auth().wait()
          // We need to authenticate again after adding a payment method. We don't need to specify the credentials because this app only uses the single default stored set of credentials.
        
        if let error = registerResponse.error {
            exit(error)
            
        } else if let error = authenticateResponse.error {
            exit(error)
        
        } else {
            let credentials = SoracomCredentials.defaultSavedCredentials()
            guard testSandboxCredentials(credentials) else {
                // The reason for doing this is to update the locally stored credentials with a new API token, after
                // registering a payment method.
                exit("unable to update API token after registering payment method")
            }
            showMainMenu("💳    Successfully added a (fake) payment method to the sandbox user's account.")
        }
    }

    
    /**
     When this action is initiated by the user, the demo program attempts to register a new SIM card via the API. It will first use the API Sandbox's own API to create a new SIM card record (this simulates putting one into inventory at e.g. Amazon or the Soracom web store, so that it can be purchased and registered). This operation should fail with an API error if the user has not yet registered a payment method, and should succeed otherwise.
     */
    open func registerNewSIM() {
        
        let createDummySIMResponse = Request.createSandboxSubscriber().wait()
        
        guard let payload = createDummySIMResponse.payload,
              let imsi    = payload[.imsi] as? String,
              let secret  = payload[.registrationSecret] as? String
        else {
            exit("unable to create dummy SIM in API Sandbox environment:\n \(createDummySIMResponse)")
        }
        
        let registerResponse = Request.registerSubscriber(imsi, registrationSecret: secret).wait()

        if let error = registerResponse.error {
            showMainMenu(error)
        } else {
            showMainMenu("""
                🙆‍♀️   OK: SIM registered successfully
                """)
        }
    }
    
    
    /**
     Not yet implented: tag a SIM with arbitrary key-value pair.
     */
    open func tagSIM() {
        showMainMenu("🤦‍♀️   NOT YET IMPLEMENTED: tagSIM()")
    }
    
    
    /**
     When this action is initiated by the user, the demo app retrieves the list of subscribers (SIMs) and prints out the list.
     */
    open func listSIMs() {
        
        let response = Request.listSubscribers().wait()
        
        if let error = response.error {
            showMainMenu(error)
        } else {
            
            guard let subscriberList = Subscriber.listFrom(response.payload) else {
                exit("failed to parse subscriber list")
            }
            
            var simDetails = ""
            
            for sim in subscriberList {
                let NO_DATA = "--"
                simDetails.append("IMSI: \(sim.imsi ?? NO_DATA)  IP: \(sim.ipAddress ?? NO_DATA)  STATUS: \(sim.status ?? NO_DATA )\n")
            }

            let banner = """
                🙆‍♀️   OK: List SIMs

                \(simDetails)
                """
            
            showMainMenu(banner)
        }
    }
    
    
    // MARK: - Internal actions that may also call the API
    
    /**
      Load stored credentials, testing to confirm they are valid, and re-create if they are not. (The API Sandbox purges credentials periodically, so old credentials may not work anymore. )
      */
    open func updateSandboxUserCredentials() {

        let foundCredentials = SoracomCredentials.defaultSavedCredentials()
        
        if !foundCredentials.blank && testSandboxCredentials(foundCredentials)  {
            return
        }
        
        log(Strings.noCredentialsExist)
        
        let ENTER = "ENTER"
        let QUIT  = "QUIT"
        // maybe add HELP someday?
        
        let enterCredentialsMenu: SimpleMenu = [
            ENTER : "Enter production SAM user authKey credentials now",
            QUIT  : "Quit this program"
        ]
        guard enterCredentialsMenu.run() == ENTER else {
            quit()
        }
        
        var readOptions = InputReaderOptions()
        readOptions.minLength = 38
        readOptions.maxLength = 38
        readOptions.prohibit  = CharacterSet(charactersIn: "-01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
        
        let idReader  = InputReader(options: readOptions)
        let authKeyId = idReader.getInputUntilValid(message: Strings.pleaseEnterProductionAuthKeyID)
        
        readOptions.minLength = 71
        readOptions.maxLength = 71
        
        let secretReader  = InputReader(options: readOptions)
        let authKeySecret = secretReader.getInputUntilValid(message: Strings.pleaseEnterProductionAuthKeySecret)
        
        let temporaryProductionCredentials = SoracomCredentials(authKeyId: authKeyId, authKeySecret: authKeySecret)
        
        // Since we are in a command-line context, we are just going to do all of this
        // work serially, in order, so we will use Request's wait() method. For a more
        // flexible way to do this asynchronously, see Client.createSandboxUser().
        
        let uuid     = UUID().uuidString
        let email    = "demo-user-\(uuid)@example.com"
        let password = "password-\(uuid)aBc0157$"

        // The methods below handle unexpected errors by printing them, then exiting the program.
        
        createOperator(email: email, password: password)
        
        let tokenCredentials = getSignupToken(sandboxUserEmail: email, productionCredentials: temporaryProductionCredentials)
        
        verifyOperator(tokenCredentials)
        
        let sandboxCredentials = SoracomCredentials(type: .RootAccount, emailAddress: email, password: password)

        log("""
            👍   Finished creating a user in the API Sandbox environment.
                 Sandbox user credentials have been saved for future use.
            """)
        
        if (!testSandboxCredentials(sandboxCredentials)) {
            exit("""
                Created sandbox user credentials, but they don't work.
                That is unexpected. For this demo program, it's a fatal error.
                """)
        }
        
        // If we get here, it means testSandboxCredentials() succeeded, and has updated the credentials with a new API token, and saved them
    }
    
    
    /**
      Authenticate by logging into the API Sandbox with `credentials`, updating the API token and saving the updated credentials on success. Returns true if authentication succeeds, false otherwise.
     */
    open func testSandboxCredentials(_ credentials: SoracomCredentials) -> Bool {
        
        log("Testing sandbox user credentials...")
        
        var credentials = credentials;
        var result = false
        
        let authResponse = Request.auth(credentials).wait()
        
        if let payload = authResponse.payload,
            let apiKey  = payload[.apiKey] as? String,
            let token   = payload[.token] as? String
        {
            credentials.apiKey = apiKey
            credentials.token  = token
            saveSandboxUserCredentials(credentials: credentials)
            
            result = true
        }
        
        log(result ? " OK." : "FAILED", prepend: nil)
        return result
    }
    
    
    /**
      Save `credentials` to persistent storage.
     */
    open func saveSandboxUserCredentials(credentials: SoracomCredentials) {
        
        let saveResult = credentials.save();
          // Since this demo program only stores a single set of credentials (those of the demo user in the sandbox environment), we don't have to worry about the save identifier and namespace used for saving, like we might in an app that manages multiple API users.
        
        if (!saveResult) {
            exit("Saving credentials failed unexpectedly.")
        }
    }
    
    
    /**
      Does the equivalent of signing up via the web signup form. This creates a user account, which must then be verified before it can be used.
     */
    open func createOperator(email: String, password: String) {
        
        log("OK, next we will try to create an API Sandbox user...")
        
        log("""
            This operation will attempt to create a sandbox user for testing,
            in the API sandbox.
            """)
        log("  Email Address: \(email)", prepend: "\n")
        log("  Password:      \(password)", prepend: "\n")
        
        let createOperatorRequest  = Request.createOperator(email, password: password)
        let createOperatorResponse = createOperatorRequest.wait()
        
        if let error = createOperatorResponse.error {
            self.exit(error)
        } else {
            log("👍   Create Operator (\"sign up\") in API Sandbox environment succeeded.")
        }
    }
    
    
    /**
      Retrieves a signup token via the sandbox API. This is the one step that requires real SAM user credentials from the production environment. This is step 1/2 of verifying a new operator (Soracom user).
     */
    open func getSignupToken(sandboxUserEmail: String, productionCredentials: SoracomCredentials) -> SoracomCredentials {
        
        let signupRequest  = Request.getSignupToken(email: sandboxUserEmail,
                                                    authKeyId: productionCredentials.authKeyID,
                                                    authKey: productionCredentials.authKeySecret)
        
        let signupResponse = signupRequest.wait()
        
        if let error = signupResponse.error {
            
            exit(error)
        
        } else {
        
            log("""
                👍   Get Signup Token (equivalent of getting the sign up confirmation
                link via email) in API Sandbox environment succeeded.
                """)
            
            guard let token = signupResponse.payload?[.token] as? String else {
                exit("Expected sign-up token was not found in the API response: \(signupResponse)")
            }
            return SoracomCredentials(token: token)
        }
    }
    
    
    /**
     Verifies a newly-created operator (Soracom user). This is step 2/2 of verifying a new operator (Soracom user). This verification process simulates the user verifying their account by clicking the special link that is normally sent by email when users sign up for a Soracom acccount. This process must be completed before a new user can perform actions via the API (in the API Sandbox, in the case of this demo program).
     */
    open func verifyOperator(_ tokenCredentials: SoracomCredentials) {
        
        let verifyOperatorRequest  = Request.verifyOperator(token: tokenCredentials.token)
        
        let verifyOperatorResponse = verifyOperatorRequest.wait()
        
        if let error = verifyOperatorResponse.error {
            
            exit(error)
        }
        // else do nothing and continue
    }
    
    
    // MARK: - UI & menu display
    
    /**
      Shows the initial welcome message banner.
     */
    open func showWelcomeMessage() {
        log(Strings.welcome)
    }
    
    
    /**
     Displays the main menu, optionally preceded by a text banner. The banner might inform the user of the results of the previous operation, or that an error occurred.
     */
    open func showMainMenu(bannerText: String? = nil) {
        
        if let bannerText = bannerText {
            log(bannerText)
        }
        
        let PAYMENT  = "PAYMENT"
        let REGISTER = "REGISTER"
        let TAG      = "TAG"
        let LIST     = "LIST"
        let QUIT     = "QUIT"
        
        let mainMenu: SimpleMenu = [
            PAYMENT  : "Register a (simulated) payment method",
            REGISTER : "Register a new SIM in the API Sandbox",
            TAG      : "Add a custom tag to a SIM",
            LIST     : "List all SIMs currently registered",
            QUIT     : "Quit this program"
        ]
        
        let choice = mainMenu.run()
        
        if choice == PAYMENT {
            registerPaymentMethod()
            
        } else if choice == REGISTER {
            registerNewSIM()
            
        } else if choice == TAG {
            tagSIM()
            
        } else if choice == LIST {
            listSIMs()
            
        } else if choice == QUIT {
            quit()
            
        } else {
            exit("Somebody forgot to implement \(choice)")
        }
    }
    
    
    /**
     Convenience form to show the main menu after displaying an error that has occurred.
     */
    open func showMainMenu(_ apiError: APIError) {
        log(apiError)
        showMainMenu()
    }
    

    /**
     Convenience form to show the main menu after displaying `bannerText`.
     */
    open func showMainMenu(_ bannerText: String) {
        log(bannerText)
        showMainMenu()
    }
    

    // MARK: - Utility methods

    /**
     Convenience form to exit the program after displaying an error.
     */
    open func exit(_ apiError: APIError) -> Never {
        
        log("""
            💣   (T_T) Uh-oh, the API returned an unexpected error:
            💣   Code: \(apiError.code)
            💣   Message: \(apiError.message)
            """)
        log("")
        Foundation.exit(5);
    }
    
    
    /**
     Convenience form to exit the program after displaying the text `message`.
     */
    open func exit(_ message: String) -> Never {
        log("""
            💀   (T_T) Uh-oh, this demo program encountered an unexpected error:
            💀   \(message)
            """)
        log("")
        Foundation.exit(6);
    }
    
    
    /**
     Exits the program normally, because the user wants to quit.
     */
    open func quit() -> Never {
        log("""
            👾   Thank you for playing!
            👾         GAME OVER
            

            """)

        Foundation.exit(0);
    }
    
    
    /**
     For now, log is basically just print(). But it could get slightly fancier in future (e.g. actually also log to file).
     */
    open func log(_ what: Any, prepend prefix: String? = "\n\n") {
        print("\(prefix ?? "")\(String(describing: what))", terminator: "")
    }
    
    
    /**
     Convenience form to log an API error returned by the API.
     */
    open func log(_ apiError: APIError) {
        log("""
            🙅‍♀️   (T_T) Uh-oh, the API returned an error:
            🙅‍♀️   Code: \(apiError.code)
            🙅‍♀️   Message: \(apiError.message)
            """)
        log("")
    }
}
