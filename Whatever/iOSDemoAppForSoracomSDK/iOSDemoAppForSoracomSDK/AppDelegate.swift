// AppDelegate.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        print("🤖 Welcome to the iOS Demo App for the Soracom Swift SDK.")
        
        
        
        Request.credentialsFinder = { (req) in
            
            // For almost everything it does, this app will use the credentials for the API Sandbox user.
            // The only exception is the real SAM user credentials it needs to create the sandbox user.
            
            return Client.sharedInstance.credentialsForSandboxUser
        }
        
        print("Credentials for API Sandbox user: \(Client.sharedInstance.credentialsForSandboxUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        print("Credentials for production SAM user: \(Client.sharedInstance.credentialsForProductionSAMUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        
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
        
        if (authKeyId.characters.count > 2 && authKeySecret.characters.count > 2) {

            let productionCredentials = SoracomCredentials(type: .AuthKey, authKeyID: authKeyId, authKeySecret: authKeySecret)
            Client.sharedInstance.saveCredentialsForProductionSAMUser(productionCredentials)
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
        

        return true
    }
    
    
}

