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
            
            return Credentials.credentialsForSandboxUser
        }
        
        print("Credentials for API Sandbox user: \(Credentials.credentialsForSandboxUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        print("Credentials for production SAM user: \(Credentials.credentialsForProductionSAMUser.blank ? "⚠️ ABSENT" : "✓ PRESENT")")
        
        // To make all the automated tests run, you need to enter real production credentials for a SAM user.
        // But is very cumbersome to enter text into the iOS Simulator. One alternative is to enter your
        // credentials below and uncomment the code and run it once. (Then, undo your changes.)
        //
                let authKeyId      = "keyId-ZFdYUtCstiVgpFragbOPhsdSOCuMGUSR"
                let authKeySecret  = "secret-bUAvMnBlBv0KsjYsHSIvwDnoCLhQbOFXYoDAAmqwCPzI1TkXiQZgN5ZvcFDVSoA9"
                let samCredentials = SoracomCredentials(type: .AuthKey, authKeyID: authKeyId, authKeySecret: authKeySecret)
                let saved = Credentials.saveCredentialsForProductionSAMUser(samCredentials)
                print("Save credential result: \(saved)")

        // Uncommenting the below can be useful for debugging:
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
        
        Credentials.authenticateAsSandboxUser() // udpate the status display

        return true
    }
    
    
}

